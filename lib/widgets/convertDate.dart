String correctlyFormattedDateTime(DateTime date) {
  if (date.month.toString().length == 1 && date.day.toString().length == 1) {
    return '${date.year}-0${date.month}-0${date.day}';
  } else if (date.day.toString().length == 1) {
    return '${date.year}-${date.month}-0${date.day}';
  } else if (date.month.toString().length == 1) {
    return '${date.year}-0${date.month}-${date.day}';
  } else
    return '${date.year}-${date.month}-${date.day}';
}

// ignore: non_constant_identifier_names
int CorrectlyDateTimeToInt(DateTime date1, DateTime date2) {
  return date1.year - date2.year;
}
