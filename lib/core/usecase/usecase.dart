abstract class UseCase<P, R> {
  const UseCase();

  Future<R> execute(P param);
}
