// ignore: non_constant_identifier_names
OtherFunction(String send, String other) {
  if (send.contains('Other')) {
    List l = send.split(',');
    l.remove('Other');
    send = l.join(",");
    if (send == '') {
      send = other;
    } else {
      send = send + ',' + other;
    }
  }
  return send;
}

// ignore: non_constant_identifier_names
OtherFunction2(String prescribedfor, String other) {
  if (prescribedfor == "Other") {
    prescribedfor = other;
  }
  return prescribedfor;
}
