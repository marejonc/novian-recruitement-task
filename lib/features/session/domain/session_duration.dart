/// Session lengths offered on the session screen.
enum SessionDuration {
  oneMinute(1),
  threeMinutes(3),
  fiveMinutes(5);

  new(this.minutes);

  final int minutes;
}
