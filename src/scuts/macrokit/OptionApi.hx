package scuts.macrokit;

typedef Option<T> = haxe.ds.Option<T>;



class OptionApi {
	public static function getOrElseConst <T>(o:Option<T>, elseValue:T):T return switch (o)
	{
		case Some(v): v;
		case None:    elseValue;
	}

	public static function map < S, T > (o:Option<S>, f:S->T):Option<T> return switch (o)
	{
		case Some(v): Some(f(v));
		case None:    None;
	}
	public static function getOrElse <T>(o:Option<T>, elseValue:Void->T):T return switch (o)
	{
		case Some(v): v;
		case None:    elseValue();
	}

	public static function flatMap < S, T > (o:Option<S>, f:S->Option<T>):Option<T> return switch (o)
	{
		case Some(v): f(v);
		case None: None;
	}

	public static function filter <T> (o:Option<T>, filter:T->Bool):Option<T> return switch (o)
	{
		case Some(v): if (filter(v)) Some(v) else None;
		case None:    None;
	}
	public static function orElse <T>(o:Option<T>, elseValue:Void->Option<T>):Option<T> return switch (o)
	{
		case Some(_): o;
		case None:    elseValue();
	}
	public static function toString <A> (o:Option<A>, toStr:A->String)
	{
		return switch (o)
		{
			case Some(v): "Some(" + toStr(v) + ")";
			case None:    "None";
		}
	}
}
