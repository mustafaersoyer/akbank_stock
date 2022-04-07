findMaxValue({List list}) {
  var max = list.first.currentPrice;
  list.forEach((element) {
    if (element.currentPrice > max) max = element.currentPrice;
  });
  return max;
}
