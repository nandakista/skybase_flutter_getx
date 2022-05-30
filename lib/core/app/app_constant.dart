const double defaultMargin = 30;

class AppConst {
  /* Validator
  ... Size Validator
   */
  static const String validSize = "Ukuran file tidak boleh melebihi 2MB.";


  /* Transaction
  ... Transaction Type
   */
  static const String fillBiodata = "lengkapi-diri";
  static const String aktaPpatAjb = "akta_jual_beli";
  static const String aktaPpatApht = "akta_pemberian_hak_tanggungan";
  static const String layananInfo = "layanan_informasi";


  /*  Actor Type for Transaction Akta
  ...APHT
  ...AJB
  ...actor role in transaction Akta
   */
  static const String actor1Ajb = "Penjual";
  static const String saksi1Ajb = "Saksi Penjual";
  static const String actor2Ajb = "Pembeli";
  static const String saksi2Ajb = "Saksi Pembeli";

  static const String actor1Apht = "Debitur";
  static const String saksi1Apht = "Saksi Debitur";
  static const String actor2Apht = "Kreditur";
  static const String saksi2Apht = "Saksi Kreditur";

  static const String actorRolePpat = "ppat";
  static const String actorRoleUmum = "umum";
  static const String actorRolePerusahaan = "perusahaan";

  /* Document Status for List By Document
  ... For feature in HOME PAGE
   */
  static const String draftDokumen = 'draft';
  static const String pendingDokumen = 'pending';
  static const String selesaiDokumen = 'selesai';

  /* Quota
  ... type of Quota
   */
  static const String quotaMeterai = 'emeterai';
  static const String quotaEform = 'eform';
  static const String quotaTtd = 'ttd';
}
