class OrderStatuses {
 static const  PLACED_BY_CUSTOMER = 'PLACED_BY_CUSTOMER';
 static const  RECEIVED_BY_STORE = 'RECEIVED_BY_STORE';
 static const  PICKED_UP = 'PICKED_UP';
 static const  DELIVERED_AND_PAID = 'DELIVERED_AND_PAID';
 static const  CANCELLED_BY_STORE = 'CANCELLED_BY_STORE';
 static const  CANCELLED_BY_CUSTOMER = 'CANCELLED_BY_CUSTOMER';
}
class ErrorStatus {
  static const NO_ACCESS = 'NO_ACCESS';
  static const PASSWORD_INVALID = 'PASSWORD_INVALID';
  static const EMAIL_EXISTS = 'EMAIL_EXISTS';
  static const USER_NOT_FOUND = 'USER_NOT_FOUND';
  static const PHONE_NUMBER_EXISTS = 'PHONE_NUMBER_EXISTS';
  static const NOT_APPROVED = 'NOT_APPROVED';
  static const INVENTORY_EMPTY = 'INVENTORY_EMPTY';
}

const String STRING_PICKED_UP =
    'Your order has been sent for delivery and is on the way.';
const String STRING_PLACED_BY_CUSTOMER =
    'Your order is awaiting store confirmation.';
const String STRING_RECEIVED_BY_STORE =
    'Your order has been confirmed. It will be on its way soon.';
const String STRING_DELIVERED_AND_PAID =
    'Your order has been delivered to you.';
const String STRING_CANCELLED_BY_STORE =
    'Your order was cancelled by the store.';
const String STRING_CANCELLED_BY_CUSTOMER = 'You cancelled this order.';
class StringResolver {
  static String getTextForOrderStatus({String status}) {
    switch (status) {
      case OrderStatuses.CANCELLED_BY_CUSTOMER:
        {
          return STRING_CANCELLED_BY_CUSTOMER;
        }
      case OrderStatuses.CANCELLED_BY_STORE:
        {
          return STRING_CANCELLED_BY_STORE;
        }
      case OrderStatuses.DELIVERED_AND_PAID:
        {
          return STRING_DELIVERED_AND_PAID;
        }
      case OrderStatuses.PICKED_UP:
        {
          return STRING_PICKED_UP;
        }
      case OrderStatuses.PLACED_BY_CUSTOMER:
        {
          return STRING_PLACED_BY_CUSTOMER;
        }
      case OrderStatuses.RECEIVED_BY_STORE:
        {
          return STRING_RECEIVED_BY_STORE;
        }
    }
    return 'INVALID_STATUS_PROVIDED';
  }
}
