import com.fox.Minigames.BlockBounds;
import com.fox.Minigames.Common.Common;
import com.fox.Minigames.Common.ItemBlock;
import com.fox.Minigames.Gridris.Gridris;
/**
 * ...
 * @author SecretFox
 */
class com.fox.Minigames.Gridris.BaseShape
{
	static var idx = 0; //unique id
	public var index:Number;
	
	public var m_Name:String;
	public var CurrentPosition:Array;
	public var rotation = 0;
	public var m_ItemId:Number;
	public var Shape:Array;
	public var m_Gridris:Gridris;
	public var KickTable:Array = 
	[
		[
			[0, 1],
			[
				[ -1, 0], [ -1, 1], [0, -2], [ -1, -2] 
			]
		],
		[
			[1, 2],
			[
				[1, 0], [1, -1], [0, 2], [1, 2]
			]
		],
		[
			[2, 3],
			[
				[1, 0], [1, 1], [0, -2], [1, -2] 
			]
		],
		[
			[3, 0],
			[
				[ -1, 0], [ -1, -1], [0, 2], [ -1, 2]
			]
		]
	];
	
	public function BaseShape(root:Gridris) 
	{
		index = idx;
		m_Gridris = root;
		idx++;
	}
	
	public function GetX(index){
		return Shape[rotation][index][0] + CurrentPosition[0];
	}
	
	public function GetY(index){
		return Shape[rotation][index][1] + CurrentPosition[1];
	}
	
	public function CanOccupy(x, y, rotation)
	{
		for (var i = 0; i < Shape[rotation].length; i++)
		{
			var GridX = Shape[rotation][i][0] + x;
			var GridY = Shape[rotation][i][1] + y;
			if (m_Gridris.GameGrid[GridX][GridY] != false)
			{
				return false;
			}
		}
		return true;
	}
	
	public function Spawn(location:Array):Boolean
	{
		CurrentPosition = location;
		DrawShape();
		return CanOccupy(CurrentPosition[0], CurrentPosition[1], rotation);
	}
	
	public function Rotate()
	{
		var newRotation = rotation + 1;
		if (newRotation > Shape.length - 1){
			newRotation = 0;
		}
		if (rotation == newRotation) return false;
		var canRotate:Boolean = CanOccupy(CurrentPosition[0], CurrentPosition[1], newRotation);
		if (canRotate)
		{
			rotation = newRotation;
			DrawShape();
			return true;
		}
		
		for (var i in KickTable)
		{
			var rotate:Array = KickTable[i][0]; // current rotation + newRotation
			var kicks:Array = KickTable[i][1]; // list of positions to kick the shape to
			if ( rotate[0] == rotation && rotate[1] == newRotation)
			{
				for (var y in kicks)
				{
					var kickOffset:Array = kicks[y];
					canRotate = CanOccupy(CurrentPosition[0] + kickOffset[0], CurrentPosition[1] + kickOffset[1], newRotation);;
					if ( canRotate)
					{
						rotation = newRotation;
						CurrentPosition[0] += kickOffset[0];
						CurrentPosition[1] += kickOffset[1];
						DrawShape();
						return true;
					}
				}
			}
		}
		return canRotate;
	}
	
	public function DrawShape()
	{
		for (var i = 0; i < Shape[rotation].length; i++)
		{
			var bounds:BlockBounds = Common.GetBlockBounds(m_Gridris.m_Inventory, GetX(i), GetY(i));
			
			var BlockClip:MovieClip = m_Gridris.m_GameClip[index + "_" + i];
			if (!BlockClip)
			{
				BlockClip = m_Gridris.m_GameClip.createEmptyMovieClip(index + "_" + i, m_Gridris.m_GameClip.getNextHighestDepth());
				var itemblock:ItemBlock = new ItemBlock(BlockClip);
				itemblock.SetData(m_ItemId, bounds);
			}
			BlockClip._x = bounds.x;
			BlockClip._y = bounds.y;
		}
	}
}