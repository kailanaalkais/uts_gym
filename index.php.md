```php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar gym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- <style>
        .btn-group-action {
            white-space: nowrap;
        }
    </style> -->
    <style>
        body {
            background-color:rgb(241, 255, 255);
            font-family: 'Arial', sans-serif;
            color:rgb(207, 244, 255);
        }
        h1 {
            text-align: center;
            margin: 20px 0;
            color:rgb(38, 43, 42);
            font-weight: bold;
        }
        .container {
            max-width: 900px;
            margin: auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .table {
            margin-top: 20px;
        }
        .modal-header {
            background-color:rgb(0, 46, 95);
            color: white;
        }
        .modal-footer {
            justify-content: space-between;
        }
        .btn-group-action {
            white-space: nowrap;
        }
        .btn-primary, .btn-success {
            margin-right: 10px;
        }
        .form-label {
            font-weight: bold;
        }
        .alert {
            margin: 20px;
        }
        .search-container {
            margin-bottom: 20px;
        }
        .btn {
            transition: background-color 0.3s, color 0.3s;
        }
        .btn:hover {
            background-color: #0056b3;
            color: white;
        }
        .btn-success:hover {
            background-color: #28a745;
            color: white;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f8f9fa;
        }
        .table-striped tbody tr:hover {
            background-color: #e2e6ea;
        }
    </style>
    </head>
    <button class="logout-btn" onclick="window.location.href='logout.php'">Logout</button>
<h1>Daftar gym</h1>
    
    <div class="row mb-3">
        <div class="col">
            <input type="text" id="searchInput" class="form-control" placeholder="Cari berdasarkan ID">
        </div>
        <div class="col-auto">
            <button onclick="searchgym()" class="btn btn-primary">Cari</button>
        </div>
        <div class="col-auto">
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#gymModal">
                Tambah gym
            </button>
        </div>
    </div>

    <table class="table table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Type</th>
                <th>Kondisi</th>
                <th>Quantity</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody id="gymList">
        </tbody>
    </table>

    <!-- Modal untuk Tambah/Edit gym -->
    <div class="modal fade" id="gymModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Tambah gym</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="gymForm">
                        <input type="hidden" id="gymId">
                        <div class="mb-3">
                            <label for="name" class="form-label">Nama</label>
                            <input type="text" class="form-control" id="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="type" class="form-label">Type</label>
                            <input type="type" class="form-control" id="type" required>
                        </div>
                        <div class="mb-3">
                            <label for="kondisi" class="form-label">Kondisi</label>
                            <input type="text" class="form-control" id="kondisi" required>
                        </div>
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Quantity</label>
                            <input type="number" class="form-control" id="quantity" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="button" class="btn btn-primary" onclick="savegym()">Simpan</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const API_URL = 'http://localhost/gym/gym.php';
        let gymModal;

        document.addEventListener('DOMContentLoaded', function() {
            gymModal = new bootstrap.Modal(document.getElementById('gymModal'));
            loadgym(); // Memuat semua gym saat halaman pertama kali dibuka
        });

        function loadgym() {
            fetch(API_URL)
                .then(response => response.json())
                .then(gym => {
                    const gymList = document.getElementById('gymList');
                    gymList.innerHTML = '';
                    gym.forEach(gym => {
                        gymList.innerHTML += 
                            `<tr>
                                <td>${gym.id}</td>
                                <td>${gym.name}</td>
                                <td>${gym.type}</td>
                                <td>${gym.kondisi}</td>
                                <td>${gym.quantity}</td>
                                <td class="btn-group-action">
                                    <button class="btn btn-sm btn-warning me-1" onclick="editgym(${gym.id})">Edit</button>
                                    <button class="btn btn-sm btn-danger" onclick="deletegym(${gym.id})">Hapus</button>
                                </td>
                            </tr>`;
                    });
                })
                .catch(error => alert('Error loading gym: ' + error));
        }
        function logout() {
            // Logic for logging out (clear session, redirect, etc.)
            alert('You have been logged out');
            window.kondisi.href = 'login.php';  // Redirect to login page
        }

        function searchgym() {
            const id = document.getElementById('searchInput').value.trim();
            if (!id) {
                loadgym(); // Jika input ID kosong, tampilkan semua gym
                return;
            }

            // URL untuk mencari gym berdasarkan ID
            const url = `${API_URL}/${id}`;

            fetch(url)
                .then(response => response.json())
                .then(gym => {
                    const gymList = document.getElementById('gymList');
                    gymList.innerHTML = '';

                    if (gym.message) {
                        alert('gym not found');
                        return;
                    }

                    gymList.innerHTML = 
                        `<tr>
                            <td>${gym.id}</td>
                            <td>${gym.name}</td>
                            <td>${gym.type}</td>
                            <td>${gym.kondisi}</td>
                            <td>${gym.quantity}</td>
                            <td class="btn-group-action">
                                <button class="btn btn-sm btn-warning me-1" onclick="editgym(${gym.id})">Edit</button>
                                <button class="btn btn-sm btn-danger" onclick="deletegym(${gym.id})">Hapus</button>
                            </td>
                        </tr>`;
                })
                .catch(error => alert('Error searching gym: ' + error));
        }

        function editgym(id) {
            fetch(`${API_URL}/${id}`)
                .then(response => response.json())
                .then(gym => {
                    document.getElementById('gymId').value = gym.id;
                    document.getElementById('name').value = gym.name;
                    document.getElementById('type').value = gym.type;
                    document.getElementById('kondisi').value = gym.kondisi;
                    document.getElementById('quantity').value = gym.quantity;
                    document.getElementById('modalTitle').textContent = 'Edit gym';
                    gymModal.show();
                })
                .catch(error => alert('Error loading gym details: ' + error));
        }

        function deletegym(id) {
            if (confirm('Are you sure you want to delete this gym?')) {
                fetch(`${API_URL}/${id}`, { method: 'DELETE' })
                    .then(response => response.json())
                    .then(data => {
                        alert('gym deleted successfully');
                        loadgym();
                    })
                    .catch(error => alert('Error deleting gym: ' + error));
            }
        }

        function savegym() {
            const gymId = document.getElementById('gymId').value;
            const gymData = {
                name: document.getElementById('name').value,
                type: document.getElementById('type').value,
                kondisi: document.getElementById('kondisi').value,
                quantity: document.getElementById('quantity').value
            };

            const method = gymId ? 'PUT' : 'POST';
            const url = gymId ? `${API_URL}/${gymId}` : API_URL;

            fetch(url, {
                method: method,
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(gymData)
            })
            .then(response => response.json())
            .then(data => {
                alert(gymId ? 'gym uptyped successfully' : 'gym added successfully');
                gymModal.hide();
                loadgym();
                resetForm();
            })
            .catch(error => alert('Error saving gym: ' + error));
        }

        function resetForm() {
            document.getElementById('gymId').value = '';
            document.getElementById('gymForm').reset();
            document.getElementById('modalTitle').textContent = 'Tambah gym';
        }

        // Reset form when modal is closed
        document.getElementById('gymModal').addEventListener('hidden.bs.modal', resetForm);
    </script>
</body>
</html>
```
