// validation_regex.dart

RegExp EMAIL_VALIDATION_REGEX = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

RegExp PASSWORD_VALIDATION_REGEX =
    RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");

RegExp NAME_VALIDATION_REGEX = RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");

RegExp FIRST_NAME_VALIDATION_REGEX = RegExp(r"^[A-ZÀ-ÿ][a-zA-ZÀ-ÿ-.' ]*$");

RegExp LAST_NAME_VALIDATION_REGEX = RegExp(r"^[A-ZÀ-ÿ][a-zA-ZÀ-ÿ-.' ]*$");

RegExp PHONE_NUMBER_VALIDATION_REGEX =
    RegExp(r"^\+?(\d{1,3})?[-.\s]?\(?\d{1,4}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}$");

RegExp ADDRESS_VALIDATION_REGEX = RegExp(r"^[a-zA-Z0-9\s,.-]+$");

RegExp GENDER_VALIDATION_REGEX =
    RegExp(r"^(Male|Female|Other|Prefer not to say)$");

RegExp CONFIRM_PASSWORD_VALIDATION_REGEX =
    RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");