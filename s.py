from flask import Flask, render_template, Response, request, redirect, url_for, session
import cv2
import mysql.connector
from ultralytics import YOLO

app = Flask(__name__)
app.secret_key = 'your_secret_key'

# Connect to MySQL
conn = mysql.connector.connect(host='localhost', user='root', password='', database='job_allocation')
cursor = conn.cursor()

# Load YOLO model
model = YOLO("best.pt")  # Your trained YOLO model

# Job mapping
job_mapping = {
    "tree_fall": "Tree Fall",
    "road_crack": "Road Pathology",
    "pothole": "Road Pathology"
}
def generate_frames():
    cap = cv2.VideoCapture(0)  # Open webcam
    if not cap.isOpened():
        return

    while True:
        success, frame = cap.read()
        if not success:
            break

        results = model(frame)
        detected_issues = []

        # Process detected issues
        for r in results:
            for box in r.boxes:
                x1, y1, x2, y2 = map(int, box.xyxy[0])
                conf = float(box.conf[0])
                cls = int(box.cls[0])
                label = f"{model.names[cls]} {conf:.2f}"
                detected_issues.append((label, x1, y1, x2, y2, 'Pending', None, job_mapping.get(model.names[cls], 'Unknown')))
                cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 255, 0), 2)
                cv2.putText(frame, label, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)
        # Insert detected issues into the database
        if detected_issues:
            try:
                cursor.executemany("INSERT INTO tasks (issue, x1, y1, x2, y2, status, assigned_user, job_type) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", detected_issues)
                conn.commit()
            except mysql.connector.Error as e:
                print(f"Error inserting into database: {e}")

        ret, buffer = cv2.imencode('.jpg', frame)
        frame = buffer.tobytes()
        yield (b'--frame\r\n' b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

    cap.release()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']

    if username == "admin" and password == "admin123":
        session['user'] = username
        session['role'] = 'admin'
        return redirect(url_for('admin_dashboard'))
    
    cursor.execute("SELECT username FROM users WHERE username=%s AND password=%s", (username, password))
    user = cursor.fetchone()
    if user:
        session['user'] = username
        session['role'] = 'user'
        return redirect(url_for('user_dashboard'))
    
    return "Invalid Credentials!", 401

@app.route('/admin_dashboard')
def admin_dashboard():
    print("Inside")
    if 'user' not in session or session['role'] != 'admin':
        return redirect(url_for('index'))
    
    cursor.execute("SELECT * FROM tasks WHERE assigned_user IS NULL OR status='Rejected'")
    tasks = cursor.fetchall()
    print(tasks)

    cursor.execute("SELECT username FROM users")
    users = cursor.fetchall()
    print(users)

    cursor.execute("SELECT * FROM tasks WHERE assigned_user IS NOT NULL AND status != 'Rejected'")
    assigned_tasks = cursor.fetchall()
    print(assigned_tasks)

    return render_template('admin_dashboard.html', tasks=tasks, users=users, assigned_tasks=assigned_tasks)

@app.route('/assign_task', methods=['POST'])
def assign_task():
    if 'user' in session and session['role'] == 'admin':
        task_id = request.form['task_id']
        assigned_user = request.form['assigned_user']
        cursor.execute("UPDATE tasks SET assigned_user=%s, status = %s WHERE id=%s", (assigned_user, 'Pending', task_id))
        conn.commit()
    return redirect(url_for('admin_dashboard'))

@app.route('/user_dashboard')
def user_dashboard():
    if 'user' not in session or session['role'] != 'user':
        return redirect(url_for('index'))

    cursor.execute("SELECT id, issue, status, job_type FROM tasks WHERE assigned_user=%s", (session['user'],))
    tasks = cursor.fetchall()

    return render_template('user_dashboard.html', tasks=tasks)


@app.route('/update_task_status', methods=['POST'])
def update_task_status():
    if 'user' in session and session['role'] == 'user':
        task_id = request.form['task_id']
        status = request.form['status']
        cursor.execute("UPDATE tasks SET status=%s WHERE id=%s AND assigned_user=%s", (status, task_id, session['user']))
        conn.commit()
    return redirect(url_for('user_dashboard'))

"""@app.route('/update_task_status', methods=['POST'])
def update_task_status():
    if 'user' in session and session['role'] == 'user':
        task_id = request.form['task_id']
        status = request.form['status']
        user = "NO"
        if status == "Rejected":
            cursor.execute("UPDATE tasks SET status=%s WHERE id=%s AND assigned_user=%s", (status, task_id, user)) 
        else:
            cursor.execute("UPDATE tasks SET status=%s WHERE id=%s AND assigned_user=%s", (status, task_id, session['user']))
        conn.commit()
    return redirect(url_for('user_dashboard')) """

@app.route('/video_feed')
def video_feed():
    if 'user' not in session or session['role'] != 'admin':
        return "Unauthorized", 401
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/logout')
def logout():
    session.pop('user', None)
    session.pop('role', None)
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=False)
