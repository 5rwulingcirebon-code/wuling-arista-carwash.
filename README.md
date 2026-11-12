# Wuling Arista Cirebon — Car Wash Monitoring

Aplikasi web React + Vite + Supabase untuk mencatat unit selesai cuci, berbagi database antarpetugas yang login, melihat rekap harian/bulanan/tahunan, ekspor CSV, dan menyiapkan pesan WhatsApp manual.

## Fitur
- Login dan pendaftaran akun petugas melalui Supabase Auth.
- Input nomor polisi, tipe kendaraan (19 pilihan), tanggal tanpa jam, keterangan, dan temuan.
- Tanggal default mengikuti zona waktu Asia/Jakarta.
- Data tersimpan di database online dan dapat dilihat bersama oleh semua pengguna yang sudah login.
- Riwayat dengan filter harian, bulanan, tahunan, semua data, dan pencarian nomor polisi/tipe kendaraan.
- Edit, hapus, ekspor CSV, dan tombol WhatsApp manual.
- Tombol **Simpan & Kirim ke Grup** menyimpan data ke database terlebih dahulu, lalu membuka WhatsApp dengan pesan lengkap yang sudah disiapkan.

## Menyiapkan Supabase
1. Buat project di https://supabase.com/dashboard.
2. Buka **SQL Editor**, lalu jalankan seluruh isi `supabase.sql`.
3. Buka **Project Settings → API**. Salin **Project URL** dan **anon/public key**.
4. Salin `.env.example` menjadi `.env`, lalu isi:
   ```env
   VITE_SUPABASE_URL=https://PROJECT-ID.supabase.co
   VITE_SUPABASE_ANON_KEY=ANON_PUBLIC_KEY
   ```
5. Di Supabase **Authentication → Providers → Email**, aktifkan Email. Untuk penggunaan internal, atur kebijakan konfirmasi email sesuai kebutuhan dealer.
6. Daftarkan akun petugas dari layar login aplikasi. Semua akun yang sudah login dapat melihat database bersama.

## Menjalankan lokal
Memerlukan Node.js 20 atau lebih baru.

```bash
npm install
npm run dev
```

Buka alamat lokal yang ditampilkan Vite.

## Deploy ke Vercel
1. Unggah folder project ini ke repository GitHub.
2. Impor repository di https://vercel.com/new.
3. Framework preset: **Vite**; Build Command: `npm run build`; Output Directory: `dist`.
4. Tambahkan environment variables `VITE_SUPABASE_URL` dan `VITE_SUPABASE_ANON_KEY` pada pengaturan project Vercel.
5. Deploy. Setelah URL produksi tersedia, tambahkan domain tersebut di Supabase **Authentication → URL Configuration → Site URL / Redirect URLs**.

## Alur kirim ke grup WhatsApp
1. Isi data unit lalu tekan **Simpan & Kirim ke Grup**.
2. Aplikasi menyimpan data ke Supabase. Jika penyimpanan berhasil, WhatsApp terbuka dengan teks notifikasi yang sudah terisi.
3. Di WhatsApp, pilih grup **Wuling Arista Cirebon** (atau grup tujuan yang benar), lalu tekan **Kirim**.

WhatsApp tidak menyediakan tautan web standar yang dapat memilih/mengirim ke grup secara otomatis. Karena itu petugas tetap memilih grup dan menekan Kirim secara manual. Jika WhatsApp tidak terbuka, izinkan pop-up untuk domain aplikasi. Tombol ini hanya tersedia saat membuat unit baru; saat mengedit, gunakan **Simpan perubahan**.

## Catatan keamanan
- Jangan pernah menaruh `service_role` key di frontend atau membagikannya.
- SQL mengaktifkan Row Level Security. Hanya pengguna terautentikasi dapat membaca/menulis data.
- Kebijakan awal mengizinkan semua petugas login mengedit dan menghapus catatan bersama. Batasi kebijakan ini lebih lanjut jika nanti diperlukan peran admin/petugas.
- WhatsApp masih manual: aplikasi membuka `wa.me` dengan isi pesan. Pengiriman baru terjadi setelah petugas menekan tombol Kirim di WhatsApp.
