```register php
<?php
require 'users.php'; // Pastikan file koneksi benar
$db = getConnection();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'] ?? '';
    $email = $_POST['email'] ?? '';
    $alamat = $_POST['alamat'] ?? '';
    $password = $_POST['password'] ?? '';
    $re_password = $_POST['re_password'] ?? '';

    // Validasi password dan re-password
    if ($password !== $re_password) {
        $error = "Password dan Re-password tidak cocok.";
    } else {
        // Periksa apakah username sudah ada
        $sql_check_username = "SELECT COUNT(*) FROM users WHERE username = ?";
        $stmt_check_username = $db->prepare($sql_check_username);
        $stmt_check_username->execute([$username]);
        $username_exists = $stmt_check_username->fetchColumn();

        if ($username_exists > 0) {
            $error = "Username sudah digunakan. Silakan gunakan username lain.";
        } else {
            // Periksa apakah email sudah ada
            $sql_check_email = "SELECT COUNT(*) FROM users WHERE email = ?";
            $stmt_check_email = $db->prepare($sql_check_email);
            $stmt_check_email->execute([$email]);
            $email_exists = $stmt_check_email->fetchColumn();

            if ($email_exists > 0) {
                $error = "Email sudah terdaftar. Silakan gunakan email lain.";
            } else {
                // Simpan data jika username dan email belum ada
                $hashed_password = password_hash($password, PASSWORD_BCRYPT);
                $sql = "INSERT INTO users (username, email, alamat, password) VALUES (?, ?, ?, ?)";
                $stmt = $db->prepare($sql);

                if ($stmt->execute([$username, $email, $alamat, $hashed_password])) {
                    header("Location: login.php"); // Redirect ke halaman login
                    exit();
                } else {
                    $error = "Terjadi kesalahan saat registrasi.";
                }
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Registrasi</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #8e44ad, #3498db);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 100%;
            max-width: 400px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            padding: 30px 20px;
            box-sizing: border-box;
        }

        h1 {
            text-align: center;
            color: #34495e;
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 500;
        }

        .input-group {
            margin: 15px 0;
            position: relative;
        }

        .input-group label {
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
            display: block;
        }

        .input-group input {
            width: 100%;
            padding: 12px 40px 12px 12px;
            border: 1px solid #dcdcdc;
            border-radius: 5px;
            background-color: #f9f9f9;
            font-size: 14px;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }

        .input-group input:focus {
            border-color: #3498db;
            outline: none;
        }

        .input-group i {
            position: absolute;
            top: 66%;
            right: 12px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #888;
        }

        .input-group i:hover {
            color: #3498db;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #3498db;
            border: none;
            color: white;
            font-size: 16px;
            font-weight: 500;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #2980b9;
        }

        p {
            text-align: center;
            font-size: 14px;
            color: #555;
        }

        a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }

        a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-bottom: 15px;
            font-size: 14px;
        }
    </style>
    <script>
        function togglePasswordVisibility(id, iconId) {
            const input = document.getElementById(id);
            const icon = document.getElementById(iconId);
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Form Registrasi</h1>
        <?php if (!empty($error)) echo "<p class='error-message'>$error</p>"; ?>
        <form action="register.php" method="POST">
            <div class="input-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" placeholder="Masukkan username" required>
            </div>

            <div class="input-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Masukkan email" required>
            </div>

            <div class="input-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Masukkan password" required>
                <i id="togglePassword" class="fas fa-eye" onclick="togglePasswordVisibility('password', 'togglePassword')"></i>
            </div>

            <div class="input-group">
                <label for="re_password">Re-Password:</label>
                <input type="password" id="re_password" name="re_password" placeholder="Ulangi password" required>
                <i id="toggleRePassword" class="fas fa-eye" onclick="togglePasswordVisibility('re_password', 'toggleRePassword')"></i>
            </div>

            <button type="submit">Register</button>
        </form>
        <p>Sudah punya akun? <a href="login.php">Login di sini</a></p>
    </div>
</body>
</html>

```
