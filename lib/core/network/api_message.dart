class ApiMessage {
  static message(String errorMessage) {
    switch (errorMessage) {
      case "User not found" :
        return "Pengguna tidak ditemukan. \nSilahkan melakukan pendaftaran terlebih dahulu.";

      case "user not found" :
        return "Pengguna tidak ditemukan.";

      case "No User Found" :
        return "Nomor telepon tidak terdaftar. \nSilahkan melakukan pendaftaran terlebih dahulu.";

      case "Wrong Password":
        return "Password yang anda masukan salah!";

      case "Silahkan cek email verifikasi dari tekenaja":
        return "Silahkan cek email verifikasi Anda.";

      case "NIK not found":
        return "Pengguna tidak ditemukan.";

      case "email not found":
        return "Email tidak ditemukan.";

      case "Phone Not Verified":
        return "Pengguna tidak ditemukan. Mohon lakukan registrasi.";

      case "Email Used" :
        return "Email telah digunakan. Silahkan mendaftar menggunakan email lain atau login menggunakan email tersebut.";

      case "Phone Used" :
        return "Nomor Telepon telah terdaftar. \nSilahkan login dengan nomor tersebut.";

      case "phone not valid" :
        return "Nomor Telepon tidak valid.";

      case "OTP not valid" :
        return "Kode OTP salah.\nMohon periksa kembali.";

      case "OTP expired" :
        return 'Kode OTP kadaluarsa. \nSilahkan melakukan resend kode.';

      case "user is active" :
        return "Nomor telah aktif. Mohon kembali ke laman login dan lanjutkan ke proses login!";

      case "no_nik used" :
        return "NIK telah digunakan!";

      case "Nomor NIK not valid" :
        return "Nomor NIK salah. \nMohon periksa kembali.";

      case "Nama harus sesuai KTP" :
        return "Nama harus sesuai KTP.";

      case "Tempat lahir harus sesuai KTP" :
        return "Tempat lahir harus sesuai KTP.";

      case "Tanggal lahir harus sesuai KTP" :
        return "Tanggal lahir harus sesuai KTP.";

      case "Photo not valid" :
        return "Foto selfie tidak valid atau tidak sesuai dengan pemilik KTP.";

      case "user belum mendaftarkan CA":
        return "Mohon verifikasi email terlebih dahulu untuk mendapatkan Certificate of Authority (CA).";

      case "Maaf, quota habis." :
        return "Maaf kuota meterai anda habis.\n Segera isi ulang kuota anda.";

      default:
        return errorMessage;
    }
  }
}