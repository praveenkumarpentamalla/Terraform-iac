# **DevOps Project: 3-Tier Architecture Setup**

## **Table of Contents**
1. [Introduction to 3-Tier Architecture](#1-introduction-to-3-tier-architecture)
2. [Web Server Setup](#2-web-server-setup)
3. [Application Server Setup](#3-application-server-setup)
4. [Database Server Setup](#4-database-server-setup)
5. [Artifactory Setup (JFrog)](#5-artifactory-setup-jfrog)
6. [Best Practices](#6-best-practices)
7. [Summary](#7-summary)

---

## **1. Introduction to 3-Tier Architecture**

A 3-tier architecture separates an application into three logical layers:
1. **Web Server**: Handles user interface and requests (e.g., Apache, Nginx).
2. **Application Server**: Processes business logic (e.g., Java, Python, Node.js).
3. **Database Server**: Manages data storage and retrieval (e.g., MySQL, ArangoDB).

### **Benefits:**
- Scalability: Each tier can be scaled independently.
- Security: Isolation between tiers reduces risks.
- Maintainability: Easier to update and manage.

---

## **2. Web Server Setup**

### **Install Apache (httpd):**
```bash
# Update packages
apt update && apt upgrade -y

# Install Apache
apt install apache2 -y

# Start Apache (if not auto-started)
systemctl start apache2

# Verify installation
systemctl status apache2
```

### **Install Nginx:**
```bash
# Install Nginx
apt install nginx -y

# Start Nginx
systemctl start nginx

# Verify installation
systemctl status nginx
```

### **Deploy a Sample Application:**
```bash
# Clone a sample application (e.g., Netflix UI)
git clone <repository-url>

# Move files to web server directory
cp -r <cloned-folder>/* /var/www/html/
```

### **Access the Web Server:**
- Use the public IP of the web server in a browser (port 80).

---

## **3. Application Server Setup**

### **Install Java:**
```bash
# Install JRE and JDK
apt install default-jre default-jdk -y

# Verify installation
java -version
javac -version

# Set JAVA_HOME (add to /etc/profile.d/jdk.sh)
export JAVA_HOME=/usr/lib/jvm/default-java
export PATH=$PATH:$JAVA_HOME/bin

# Apply changes
source /etc/profile
```

### **Install Python:**
```bash
# Install Python 3
apt install python3 -y

# Install additional libraries
pip3 install numpy pandas

# Verify installation
python3 --version
```

### **Install Node.js:**
```bash
# Install Node.js
apt install nodejs -y

# Verify installation
node -v
npm -v
```

### **Run a Sample Application:**
- For Java: Compile and run a `.java` file.
- For Python: Execute a `.py` script.
- For Node.js: Run a `.js` file.

---

## **4. Database Server Setup**

### **Install ArangoDB:**
```bash
# Download the repository and key
curl -OL https://download.arangodb.com/arangodb38/Community/Linux/arangodb3-latest-linux-amd64.tar.gz
tar -xf arangodb3-latest-linux-amd64.tar.gz

# Install dependencies
apt install -y transport-https

# Install ArangoDB
dpkg -i arangodb3-*.deb

# Start ArangoDB
systemctl start arangodb3

# Check status
systemctl status arangodb3

# Access ArangoDB shell
arangosh
```

### **Create a Database:**
```bash
# In ArangoDB shell
db._createDatabase("raham");
db._databases(); # List databases
```

### **Install MySQL:**
```bash
# Install MySQL
apt install mysql-server -y

# Secure installation
mysql_secure_installation

# Access MySQL shell
mysql -u root -p

# Create a database
CREATE DATABASE raham;
SHOW DATABASES;
```

---

## **5. Artifactory Setup (JFrog)**

### **Install JFrog Artifactory:**
```bash
# Download and run the installation script
curl -OL <jfrog-install-script-url>
chmod +x jfrog-install.sh
./jfrog-install.sh

# Start JFrog
systemctl start jfrog-artifactory

# Check status
systemctl status jfrog-artifactory
```

### **Access JFrog:**
- Use the public IP and port `8081` in a browser.
- Default credentials: `admin` / `password`.

### **Create a Repository:**
1. Go to **Admin > Repositories**.
2. Click **Add Repository** > **Local**.
3. Select package type (e.g., Maven).
4. Provide a name and save.

### **Note**: Prefer AWS S3 for artifact storage due to cost efficiency.

---

## **6. Best Practices**

1. **Use S3 for Artifacts**: Avoid maintaining dedicated artifactory servers.
2. **Automate Setup**: Use Ansible or Terraform for reproducible setups.
3. **Monitor Resources**: Use CloudWatch or Prometheus for monitoring.
4. **Secure Access**: Restrict SSH and database access to specific IPs.
5. **Backup Databases**: Regularly backup critical data.

---

## **7. Summary**

- **Web Server**: Hosts UI (Apache/Nginx).
- **Application Server**: Runs business logic (Java/Python/Node.js).
- **Database Server**: Stores data (MySQL/ArangoDB).
- **Artifactory**: Stores build artifacts (JFrog, but prefer S3).

### **Next Steps**:
- Practice setting up each tier manually.
- Automate the process using Ansible/Terraform.
- Explore integrating CI/CD pipelines.

---

**Note**: This project provides hands-on experience with real-world DevOps tasks. Practice each step to build confidence!
