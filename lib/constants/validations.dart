RegExp emailValidationRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

RegExp passwordValidationRegex =
    RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");

RegExp nameValidationRegex = RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");
