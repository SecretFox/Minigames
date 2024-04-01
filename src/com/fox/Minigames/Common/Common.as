/**
* ...
* @author SecretFox
*/
class com.fox.Minigames.Common.Common
{
	static function GetRandom(arr:Array)
	{
		return arr[Math.floor(Math.random() * arr.length)];
	}
	
	static function GetRandomIndex(arr:Array)
	{
		return Math.floor(Math.random() * arr.length);
	}
	
	static function GetBlockBounds(inventory:MovieClip, x:Number, y:Number)
	{
		var _x = inventory["CalculateSlotPosX"](x) - 5;
		var _y = inventory["CalculateSlotPosY"](y) - 5;
		var _x2 = inventory["CalculateSlotPosX"](x + 1) - 4;
		var _y2 = inventory["CalculateSlotPosY"](y + 1) - 4.5;
		return {x:_x, y:_y, height:_y2-_y, width:_x2-_x};
	}
	
	static function GetInventoryBoxes(name:String):Array
	{
		var boxes:Array = [];
		for (var i = 0; i < _root.backpack2.m_IconBoxes.length; i++)
		{
			if ( String(_root.backpack2.m_IconBoxes[i].m_Name).toLowerCase() == name.toLowerCase()){
				boxes.push(_root.backpack2.m_IconBoxes[i]);
			}
		}
		return boxes;
	}
}