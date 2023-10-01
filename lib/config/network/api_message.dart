/* Created by
   Varcant
   nanda.kista@gmail.com
*/
mixin ApiMessage {
  convertMessage(String errorMessage) {
    switch (errorMessage) {
      case 'User not found' :
        return 'Pengguna tidak ditemukan. \nSilahkan melakukan pendaftaran terlebih dahulu.';

      default:
        return errorMessage;
    }
  }
}