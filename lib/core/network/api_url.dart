class ApiUrl {
  static const multipartType = 'multipart/form-data';

  // Auth
  static const verifyToken = 'auth/matchtoken';
  static const login = 'auth/login';
  static const register = 'auth/register';
  static const refreshToken = 'auth/refresh';
  static const user = 'users/';
  static const emailUpdate = 'email/update';
  static const resetPass = 'resetpassword';

  // Auth Verification
  static const sendOtp = 'verifikasi/otpsms/send';
  static const otpVerif = 'verifikasi/otpsms';
  static const emailVerif = 'verifikasi/email/send';

  // Region
  static const province = '/region/province';
  static const city = '/region/city';
  static const district = '/region/district/';

  // Transaction
  static const addTransaction = 'transaction/';
  static const eForm = 'dokumen';
  static const pihakPertama = 'pihakpertama';
  static const pihakKedua = 'pihakkedua';
  static const uploadDoc = 'dokumen';
  static const stamping = 'stampmaterai';
  static const getdocument = 'getdocument';
  static const detailTransaction = 'detail';
  static const uploadStamping = 'directstampmaterai';
  static const uploadDocUmum = 'directcreate';
  static const detailDocument = 'jenisdokumen';

  // Top Up
  static const listProductPackages = 'packages';
  static const checkout = 'topup/';
  static const pricelist = 'websetting/pricelist';
  static const history = "history/";
  static const quota = "quota";

  // Biodata
  static const biodata = 'lengkapidiri/update';
  static const getUserByNik = 'lengkapidiri/nik/';

  // CA
  static const getCert = 'ca/getcert/';
  static const regCert = 'ca/register/';

  // Verify Email Lengkapi Data Diri
  static const verifyEmail = 'verifikasi/email-lengkapidiri/send';

  // Stamping
  static const stampingMaterai = 'doc/stamping';
}
