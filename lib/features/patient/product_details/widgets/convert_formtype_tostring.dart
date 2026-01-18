import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

class ConvertFormtypeTostring {
  static convertForm(FormType type) {
    switch (type) {
      case FormType.tablet:
        return 'tablets';

      case FormType.capsule:
        return 'capsule';

      case FormType.syrup:
        return 'syrup';

      case FormType.cream:
        return 'cream';

      case FormType.injection:
        return 'injection';

      case FormType.ointment:
        return 'ointment';
    }
  }
}
