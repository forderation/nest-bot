Cara Install
1. Download Project Ini
2. Start XAMPP
3. Kemudian masuk phpmyadmin buat database bernama "nest-bot-dev" tanpa tanda petik dua
4. Setelah itu import file nest-bot-dev.sql ke database yang sudah dibuat
5. Buka CMD arahkan lokasi path pada folder project ini
6. Kemudian ketik pip install -r requirements.txt
7. Setelah proses pip selesai untuk menjalankan bot ketik python main.py

COMMAND UMUM, COMMAND - DESKRIPSI
- start_bot - memulai bot
- register - register akun menggunakan NIK dan NAMA LENGKAP
- subscribe - langganan notifikasi dari bot pada chat (bisa pada group maupun chat personal bot tergantung pemanggilan command dimana)
- unsubscribe - berhenti langganan notifikasi
- seed - register akun hanya perlu memasukkan NIK (dilakukan jika data NIK sudah dimasukkan pada database sebelumnya)
- my_item - melihat item sesuai dengan barang yang dibawa
- list_code - list kode untuk menambah item
- add_item - menambah item yang belum dimasukkan ke sistem bot
- update_item - update status item yang sudah dimasukkan ke sistem bot sebelumnnya
- cancel_update - membatalkan sesi update item

COMMAND SPECIAL (sengaja tidak ditampilkan pada list command bot akan tetapi bisa dipanggil, pastikan diawali tanda "/")
- track_record - melihat track record item berdasarkan serial number
- recap_recent_item - melakukan rekap item berdasarkan update terbaru
- turn_on_reminder - menyalakan reminder notifikasi broadcast ke channel yang sudah melakukan subscribe (secara default fitur ini dimatika pada percobaan dilakukan per 30 detik tapi bisa diganti per 24 jam)
- turn_off_reminder - mematikan reminder notifikasi
- visualize_state - mendapatkan visualisasi jumlah kondisi item
- visualize_merk- mendapatkan visualisasi jumlah merk pada item yang bersangkutan
- visualize_jenis - mendapatkan visualisasi jumlah jenis pada item yang bersangkutan
- add_merk - menambah daftar merk item
- add_jenis - menambah daftar jenis item