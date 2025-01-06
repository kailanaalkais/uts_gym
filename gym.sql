-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 06 Jan 2025 pada 09.51
-- Versi server: 10.4.27-MariaDB
-- Versi PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gym`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `gym`
--

CREATE TABLE `gym` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `kondisi` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `gym`
--

INSERT INTO `gym` (`id`, `name`, `type`, `kondisi`, `quantity`) VALUES
(1, 'treadmill', 'jhonson T9S', 'baik', 2),
(2, 'dumbbell', 'hexagonal', 'baik', 1),
(3, 'barbel', 'olimpix', 'baik', 5),
(4, 'bench press', 'adjustable', 'baik', 1),
(6, 'cross trainer', 'mesin elips', 'bagus', 7),
(7, 'Smith machine', 'smith', 'karatan', 5),
(8, 'Sepeda statis ', 'statis', 'baik', 3),
(9, 'Cable machine  ', 'seated row  ', 'baik', 5),
(10, 'Dip Bar', 'hand ', 'new', 7);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `alamat`, `password`, `created_at`) VALUES
(0, 'kailanapanjend', 'kailanadanrenata@gmail.com', '', '$2y$10$o.b4Cmt06ywrsMk0xlCU4.mf/gHEKgQ85CFCtdR7pboMtoNkF7py.', '2025-01-06 08:28:21'),
(0, 'Kailanapangjend2', 'kailanadanrenata2@gmail.com', '', '$2y$10$tib6cV2gjsUbU8OkDBEQ4.XBsc1TdgVXv0qMZHP4G9o/YVtjWUBj.', '2025-01-06 08:29:54');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `gym`
--
ALTER TABLE `gym`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `gym`
--
ALTER TABLE `gym`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
