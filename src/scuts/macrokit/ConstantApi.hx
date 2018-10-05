package scuts.macrokit;

import haxe.macro.Expr;
import haxe.ds.Option;

class ConstantApi {
	public static function selectCIdentValue (c:Constant):Option<String> return switch (c)
	{
		case CIdent(s): Some(s);
		default: None;
	}

}