import '../../../utils/constants/keys.dart';
import '../../../utils/constants/enums.dart';

class ModelLogin {
  static Roles role;
  static bool isRole(Roles r) => r == role;
  static bool isAdmin() => role == Roles.superAdmin || role == Roles.admin || role == Roles.device;

  static int attemptsUnlockAdmin = 0;
  static bool unlockAdmin = false;
  static bool isMegaAdmin = false;

  static bool login(String user, pass) {
    bool result = false;

    if (user == KEYS.OFFLINE_USERNAME_SUPERADMIN &&
        pass == KEYS.OFFLINE_PASSWORD_SUPERADMIN) {
      result = true;
      role = Roles.superAdmin;
    } else if (user == KEYS.OFFLINE_USERNAME_ADMIN &&
        pass == KEYS.OFFLINE_PASSWORD_ADMIN) {
      result = true;
      role = Roles.admin;
    } else if (user == KEYS.OFFLINE_USERNAME_USER &&
        pass == KEYS.OFFLINE_PASSWORD_USER) {
      result = true;
      role = Roles.user;
    } else if (user == KEYS.OFFLINE_USERNAME_DEVICE &&
        pass == KEYS.OFFLINE_PASSWORD_DEVICE) {
      result = true;
      role = Roles.device;
    }else if (user == KEYS.OFFLINE_USERNAME_MEGAADMIN &&
        pass == KEYS.OFFLINE_PASSWORD_MEGAADMIN) {
      result = true;
      role = Roles.superAdmin;
      isMegaAdmin = true;
    }
    return result;
  }

  static String get nickname {
    switch (role) {
      case Roles.superAdmin:
        return 'superadmin_role';

      case Roles.admin:
        return 'admin_role';

      case Roles.user:
        return 'user';

      case Roles.device:
        return 'Administrador de dispositivos (Sin red)';

      default:
        return 'Role Error';
    }
  }
}
