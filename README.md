# TUGAS UTS
NAMA : KAILANA AL KAIS  
NIM : 21.01.55.0009
SISTEM INFORMASI
## DESKRIPSI PROJECT
tujuan project ini untiuk memenuhi ujian tengah semester 7

## ALAT YANG DIBUTUHKAN
1. XAMPP (atau server web lain dengan PHP dan MySQL)  
2. Text editor (misalnya Visual Studio Code, Notepad++, dll)  
3. Postman  
## MEMBUAT DATA BASE DAN TABEL DARI SQL
```SQL
SELECT * FROM `gym`
CREATE TABLE gym( id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR (50) NOT NULL, type VARCHAR(50) NOT NULL, kondisi VARCHAR(50) NOT NULL, quantity INT NOT NULL);
INSERT INTO gym (name, type, kondisi, quantity) VALUES
('treadmill', 'jhonson T9S', 'baik', '2'),
('dumbbell', 'hexagonal', 'baik','1'),
('barbel', 'olimpix', 'rusak','3'),
('bench press', 'adjustable', 'baik','1');
```
### MEMBUAT FILE GYM DALAM FOLDER HTDOCT PADA FILE C  
```PHP
<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, type, kondisi, X-Requested-With");

$method = $_SERVER['REQUEST_METHOD'];
$request = [];

if (isset($_SERVER['PATH_INFO'])) {
    $request = explode('/', trim($_SERVER['PATH_INFO'], '/'));
}

function getConnection() {
    $host = 'localhost';
    $db   = 'gym';
    $user = 'root';
    $pass = ''; // Ganti dengan password MySQL Anda jika ada
    $charset = 'utf8mb4';

    $dsn = "mysql:host=$host;dbname=$db;charset=$charset";
    $options = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ];
    try {
        return new PDO($dsn, $user, $pass, $options);
    } catch (\PDOException $e) {
        throw new \PDOException($e->getMessage(), (int)$e->getCode());
    }
}

function response($status, $data = NULL) {
    header("HTTP/1.1 " . $status);
    if ($data) {
        echo json_encode($data);
    }
    exit();
}

$db = getConnection();

switch ($method) {
    case 'GET':
        if (!empty($request) && isset($request[0])) {
            $id = $request[0];
            $stmt = $db->prepare("SELECT * FROM gym WHERE id = ?");
            $stmt->execute([$id]);
            $gym = $stmt->fetch();
            if ($gym) {
                response(200, $gym);
            } else {
                response(404, ["message" => "gym not found"]);
            }
        } else {
            $stmt = $db->query("SELECT * FROM gym");
            $gym = $stmt->fetchAll();
            response(200, $gym);
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));
        if (!isset($data->name) || !isset($data->type) || !isset($data->kondisi) || !isset($data->quantity)) {
            response(400, ["message" => "Missing required fields"]);
        }
        $sql = "INSERT INTO gym (name, type, kondisi, quantity) VALUES (?, ?, ?, ?)";
        $stmt = $db->prepare($sql);
        if ($stmt->execute([$data->name, $data->type, $data->kondisi, $data->quantity])) {
            response(201, ["message" => "gym created", "id" => $db->lastInsertId()]);
        } else {
            response(500, ["message" => "Failed to create gym"]);
        }
        break;

    case 'PUT':
        if (empty($request) || !isset($request[0])) {
            response(400, ["message" => "gym ID is required"]);
        }
        $id = $request[0];
        $data = json_decode(file_get_contents("php://input"));
        if (!isset($data->name) || !isset($data->type) || !isset($data->kondisi) || !isset($data->quantity)) {
            response(400, ["message" => "Missing required fields"]);
        }
        $sql = "UPDATE gym SET name = ?, type = ?, kondisi = ?, quantity = ? WHERE id = ?";
        $stmt = $db->prepare($sql);
        if ($stmt->execute([$data->name, $data->type, $data->kondisi, $data->quantity, $id])) {
            response (200, ["message" => "gym updated"]);
        } else {
            response(500, ["message" => "Failed to update gym"]);
        }
        break;

    case 'DELETE':
        if (empty($request) || !isset($request[0])) {
            response(400, ["message" => "gym ID is required"]);
        }
        $id = $request[0];
        $sql = "DELETE FROM gym WHERE id = ?";
        $stmt = $db->prepare($sql);
        if ($stmt->execute([$id])) {
            response(200, ["message" => "gym deleted"]);
        } else {
            response(500, ["message" => "Failed to delete gym"]);
        }
        break;

    default:
        response(405, ["message" => "Method not allowed"]);
        break;
}
?>
```
## PENGUJIAN DENGAN POSTMAN
1. Buka Postman  
2. Buat request baru untuk setiap operasi berikut:
### GET All gym
- Method: GET
- URL: http://localhost/gym/gym.php`
- Klik "Send"
### GET Specific gym
- Method: GET
- URL : http://localhost/gym/gym.php/1
- Klik "Send"
### POST New GYM
- Method: POST  
- URL: http://localhost/gym/gym.php
- Headers:
  - Key: Content-Type
  - Value: application/json
- Body:
- Pilih "raw" dan "JSON"
- Masukkan:
```php
    {
        "name": "rack squat",
        "type": "power rack",
        "kondisi": "baik",
        "quantity": 5
    }
```
- Klik "Send"
### PUT (Update) gym
- Method: PUT
- URL: http://localhost/gym/gym.php/3
- Headers:
  - Key: Content-Type
  - Value: application/json
- Body:
- Pilih "raw" dan "JSON"
- Masukkan:
```php
{
    "id": 3,
    "name": "barbel",
    "type": "olimpix",
    "kondisi": "baik",
    "quantity": 5
}
```
### DELETE gym
- Method: DELETE
- URL: http://localhost/gym/gym.php/5
- Klik "Send"
