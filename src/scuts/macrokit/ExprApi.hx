package scuts.macrokit;

#if macro

import haxe.ds.Option;
import haxe.macro.Expr;
import haxe.macro.Context;

import scuts.macrokit.Tup2Api;

using scuts.macrokit.OptionApi;
using scuts.macrokit.ArrayApi;

class ExprApi {

	public static function selectECall (e:Expr):Option<Tup2<Expr, Array<Expr>>> return {
		switch (e.expr)
		{
			case ECall(call , params): Some(Tup2Api.create(call, params));
			case _: None;
		}
	}
	public static function extractBinOpRightExpr (e:Expr, filter:Binop->Bool ):Option<Expr> return {
		switch (e.expr)
		{
			case EBinop(b, _, e2) if (filter(b)): Some(e2);
			case _: None;
		}
	}
	public static inline function inParenthesis (e:Expr) {
		return macro @:pos(e.pos) ($e);
	}

	public static inline function binopBoolAnd (left:Expr, right:Expr, pos:Position) {
		return macro @:pos(pos) $left && $right;
	}

	public static inline function mkIfExpr (cond:Expr, then:Expr, _else:Expr) {
		return macro if ($cond) $then else $_else;
	}

	public static inline function asReturn (e:Expr) {
		return macro @:pos(e.pos) return $e;
	}

	public static function mkFuncExpr (
		?name:String, ?args:Array<FunctionArg>, ?ret:ComplexType, ?eexpr:Expr,
		?params:Array<{ ?params : Array<TypeParamDecl>, name:String, ?constraints:Array<ComplexType>, ?meta : Metadata}>, ?pos:Position)
	{
		return mkExpr(EFunction(name, mkFunc(args, ret, eexpr, params)), pos);
	}

	public static inline function mkExpr (def:ExprDef, ?pos:Position):Expr
	{
		return {
			expr: def,
			pos: getPos(pos)
		}
	}


	public static function mkFuncArg (name:String, opt:Bool, ?type:ComplexType, ?value:Expr):FunctionArg {
		return {
			name:name,
			opt:opt,
			type:type,
			value:value
		}
	}
	public static function mkFunc (?args:Array<FunctionArg>, ?ret:ComplexType, ?expr:Expr, ?params:Array<{?params : Array<TypeParamDecl>, name:String, ?constraints:Array<ComplexType>, ?meta : Metadata}>) {
		return {
			args: args == null ? [] : args,
			ret: ret,
			expr: expr,
			params: params == null ? [] : params,
		}
	}

	static function getPos (pos:Null<Position>):Position {
		return if (pos == null) Context.currentPos() else pos;
	}

	public static inline function field (def:Expr, field:String, ?pos:Position) {
		return macro @:pos(getPos(pos)) $def.$field;
	}
	public static inline function call (e:Expr, params:Array<Expr>, ?pos:Position) {
		return macro @:pos(getPos(pos)) $e($a{params});
	}

	public static function selectEConstCIdentValue (e:Expr):Option<String>
	{
		return selectEConstConstant(e).flatMap(ConstantApi.selectCIdentValue);
	}

	public static function selectEConstConstant (e:Expr):Option<Constant> return {
		switch (e.expr)
		{
			case EConst(c): Some(c);
			default: None;
		}
	}

	public static function selectEConstCIdentValueInEArrayDecl (e:Expr):Option<Array<String>>
	{
		return switch (e.expr) {
			case EArrayDecl(arr):
				var r = arr.map(function (x) {
					return selectEConstConstant(x).flatMap(ConstantApi.selectCIdentValue);
				}).catOptions();

				if (r.length == arr.length) Some(r) else None;
			case EConst(CIdent(x)): Some([x]);
			case _: None;
		}
	}
}

#end