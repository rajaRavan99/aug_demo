import 'package:direct_message/Popupmenu/popupmenu_model.dart';

class MenuItemData {
  static List<MenuItems> items = [itemUse, itemShare, itemTerms, itemPrivacy];

  static const itemUse = MenuItems(text: "How To Use");
  static const itemShare = MenuItems(text: "Share App");
  static const itemTerms = MenuItems(text: "Terms and Condition");
  static const itemPrivacy = MenuItems(text: "Privacy Policy");
// MenuItems(text: 'Share App'),
// MenuItems(text: 'Terms and Conditions'),
// MenuItems(text: 'Privacy Policy')
}
