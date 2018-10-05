package scuts.macrokit;

import haxe.ds.Either;

class EitherApi {
	public static function toRight <L,R>(e:R):Either<L, R> return Right(e);
	public static function toLeft <L,R>(e:L):Either<L, R> return Left(e);

	public static function orElse<L,R>(e:Either<L,R>, left:Void->Either<L,R>):Either<L,R> return switch (e)
	{
		case Left(_): left();
		case Right(_): e;
	}

	public static function getOrElse<L,R>(e:Either<L,R>, handler:L->R):R return switch (e)
	{
		case Left(l): handler(l);
		case Right(r): r;
	}

	public static function flatMap < L,R,RR > (e:Either<L,R>, f:R->Either<L, RR>):Either<L,RR> return switch (e)
	{
		case Left(l): Left(l);
		case Right(r): f(r);
	}
	public static function map < L,R,RR > (e:Either<L,R>, f:R->RR):Either<L,RR> return switch (e)
	{
		case Left(l): Left(l);
		case Right(r): Right(f(r));
	}


}