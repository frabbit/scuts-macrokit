package scuts.macrokit;

enum Tup2<A,B> {
	Tup2(a:A, b:B);
}

class Tup2Api {
	public static function create <A,B>(a:A, b:B) return Tup2(a, b);
	public static inline function _1 <A,B>(t:Tup2<A,B>):A return switch t { case Tup2(x, _): x; };
	public static inline function _2 <A,B>(t:Tup2<A,B>):B return switch t { case Tup2(_, x): x; };
}