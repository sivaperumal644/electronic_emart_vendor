class OrderStatuses {
  static const PLACED_BY_CUSTOMER = 'PLACED_BY_CUSTOMER';
  static const RECEIVED_BY_STORE = 'RECEIVED_BY_STORE';
  static const PICKED_UP = 'PICKED_UP';
  static const DELIVERED_AND_PAID = 'DELIVERED_AND_PAID';
  static const CANCELLED_BY_STORE = 'CANCELLED_BY_STORE';
  static const CANCELLED_BY_CUSTOMER = 'CANCELLED_BY_CUSTOMER';
  static const TRANSACTION_FAILED = 'TRANSACTION_FAILED';
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

const String STRING_PICKED_UP = 'Order is picked up for delivery.';
const String STRING_PLACED_BY_CUSTOMER = 'Waiting for store confirmation';
const String STRING_RECEIVED_BY_STORE = 'Order has been confirmed';
const String STRING_DELIVERED_AND_PAID = 'Order has been delivered.';
const String STRING_CANCELLED_BY_STORE = 'Order was cancelled by the store.';
const String STRING_CANCELLED_BY_CUSTOMER = 'Customer cancelled this order.';
const String STRING_TRANSACTION_FAILED = 'Order transaction was failed.';

const String STRING_MESSAGE_PICKED_UP =
    'The order has been picked up and it is on its way for delivery.';
const String STRING_MESSAGE_PLACED_BY_CUSTOMER =
    'We’re waiting for the store to confirm your order. Once confirmed, your order will be packaged and shipped.';
const String STRING_MESSAGE_RECEIVED_BY_STORE =
    'The order has been confirmed by the store. It will be on its way for delivery soon.';
const String STRING_MESSAGE_DELIVERED_AND_PAID =
    'Order has been delivered to the customer and the payment has been succeeded.';
const String STRING_MESSAGE_CANCELLED_BY_STORE =
    'Order has been cancelled by store. So this order is currently inactive.';
const String STRING_MESSAGE_CANCELLED_BY_CUSTOMER =
    'Customer has cancelled this order. So this order is currently inactive.';
const String STRING_MESSAGE_TRANSACTION_FAILED =
    'Order transaction has been failed. So this order is currently inactive.';

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
      case OrderStatuses.TRANSACTION_FAILED:
        {
          return STRING_TRANSACTION_FAILED;
        }
    }
    return 'INVALID_STATUS_PROVIDED';
  }

  static String getMessageForOrderStatus({String status}) {
    switch (status) {
      case OrderStatuses.CANCELLED_BY_CUSTOMER:
        {
          return STRING_MESSAGE_CANCELLED_BY_CUSTOMER;
        }
      case OrderStatuses.CANCELLED_BY_STORE:
        {
          return STRING_MESSAGE_CANCELLED_BY_STORE;
        }
      case OrderStatuses.DELIVERED_AND_PAID:
        {
          return STRING_MESSAGE_DELIVERED_AND_PAID;
        }
      case OrderStatuses.PICKED_UP:
        {
          return STRING_MESSAGE_PICKED_UP;
        }
      case OrderStatuses.PLACED_BY_CUSTOMER:
        {
          return STRING_MESSAGE_PLACED_BY_CUSTOMER;
        }
      case OrderStatuses.RECEIVED_BY_STORE:
        {
          return STRING_MESSAGE_RECEIVED_BY_STORE;
        }
      case OrderStatuses.TRANSACTION_FAILED:
        {
          return STRING_MESSAGE_TRANSACTION_FAILED;
        }
    }
    return 'INVALID_STATUS_PROVIDED';
  }
}
