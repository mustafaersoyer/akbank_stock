findMinValue({List list}) {
  var min = list.first.currentPrice;
  list.forEach((element) {
    if (element.currentPrice < min) min = element.currentPrice;
  });
  return min;
}
