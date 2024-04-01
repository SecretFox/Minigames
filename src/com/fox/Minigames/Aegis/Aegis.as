import caurina.transitions.Tweener;
import com.fox.Minigames.BlockBounds;
import com.fox.Minigames.Common.Common;
import com.fox.Minigames.Common.DrawnShape;
import com.fox.Minigames.Common.IconBlock;
import com.fox.Minigames.Common.ItemBlock;
import mx.utils.Delegate;
/**
 * ...
 * @author SecretFox
 */
class com.fox.Minigames.Aegis.Aegis
{
	static var SHAPE_OROCHI0 = 0;
	static var SHAPE_OROCHI1 = 1;
	static var SHAPE_OROCHI2 = 2;
	static var SHAPE_OROCHI3 = 3;
	static var SHAPE_OROCHI4 = 4;
	
	static var BOARD_SHAPES = [
		[ // 2 Color, match 5, no osbstacles
			[], // Symmetric obstacles
			[], //Horizontally mirrored obstacles
			[], //Vertically mirrored obstacles
			[], // invidually placed obstacles
			[11,11], // Grid size
			2, // Amount of symbol types
			5, // Match count
			"Aegis (Match5)"
		],
		[ // 5 Color no obstacles
			[],
			[],
			[],
			[],
			[11,11],
			4,
			3,
			"Aegis (Match3)"
		],
		[ // Circle
			[[0, 0], [0, 1], [0, 2], [0, 3],[1, 0], [1, 1], [1, 2],[2, 0], [2, 1],[3, 0]],
			[],
			[],
			[[5, 5]],
			[11,11],
			5,
			3,
			"Aegis (Match3)"
		],
		[// Orochi
			[],
			[
				[2, 2, SHAPE_OROCHI0, 0xFFFFFF], [3, 2, SHAPE_OROCHI0, 0xFFFFFF], [4, 2, SHAPE_OROCHI0, 0xFFFFFF],
				[5, 2, SHAPE_OROCHI0, 0xFFFFFF], [6, 2, SHAPE_OROCHI0, 0xFFFFFF], [7, 2, SHAPE_OROCHI0, 0xFFFFFF], 
				[8, 2, SHAPE_OROCHI0, 0xFFFFFF], [9, 2, SHAPE_OROCHI0, 0xFFFFFF],[12, 2, SHAPE_OROCHI0, 0xFFFFFF],
				[5, 5, SHAPE_OROCHI0, 0xFFFFFF], [6, 5, SHAPE_OROCHI0, 0xFFFFFF]
			],
			[
				[2, 2, SHAPE_OROCHI0, 0xFFFFFF], [2, 3, SHAPE_OROCHI0, 0xFFFFFF], [2, 4, SHAPE_OROCHI0, 0xFFFFFF], 
				[2, 5, SHAPE_OROCHI0, 0xFFFFFF], [2, 6, SHAPE_OROCHI0, 0xFFFFFF], [2, 7, SHAPE_OROCHI0, 0xFFFFFF], 
				[2, 8, SHAPE_OROCHI0, 0xFFFFFF], [2, 9, SHAPE_OROCHI0, 0xFFFFFF], [2, 10, SHAPE_OROCHI0, 0xFFFFFF],
				[2, 11, SHAPE_OROCHI0, 0xFFFFFF], [5, 5, SHAPE_OROCHI0, 0xFFFFFF], [5, 6, SHAPE_OROCHI0, 0xFFFFFF], 
				[5, 7, SHAPE_OROCHI0, 0xFFFFFF], [5, 8, SHAPE_OROCHI0, 0xFFFFFF]
			],
			[
				[10, 2, SHAPE_OROCHI0, 0xFFFFFF], [11, 2, SHAPE_OROCHI0, 0xFFFFFF],	[9, 9, SHAPE_OROCHI0, 0xFFFFFF],
				[9, 10, SHAPE_OROCHI0, 0xFFFFFF], [9, 11, SHAPE_OROCHI0, 0xFFFFFF],	[7, 5, SHAPE_OROCHI0, 0xFFFFFF], 
				[8, 5, SHAPE_OROCHI0, 0xFFFFFF],  [2, 1, SHAPE_OROCHI1, 0xFFFFFF], [13, 2, SHAPE_OROCHI2, 0xFFFFFF],
				[12, 13, SHAPE_OROCHI3, 0xFFFFFF],[1, 12, SHAPE_OROCHI4, 0xFFFFFF]
			],
			[15,15],
			3,
			3,
			"Aegis (Match3)"
		]
	]
	static var Enum_Symmetric:Number = 0;
	static var Enum_MirroredHorizontal:Number = 1;
	static var Enum_MirroredVertical:Number = 2;
	static var Enum_Static:Number = 3;
	static var Enum_GridSize:Number = 4;
	static var Enum_SymbolCount:Number = 5;
	static var Enum_MatchCount:Number = 6;
	
	static var DEMONIC = [8443400, 0xAA0606, 6, "Demonic" ];
	static var RAMPART = [8729008, 0xf29f05, 5, "Rampart"];
	static var PSYCHIC = [8443423, 0xc175f2,4, "Psychic"];
	static var CYBERNETIC = [8443412, 0x57fdff, 3, "Cybernetic"];
	static var EXPERIMENTAL = [8728543, 0xaeadaa, 1, "Experimental"];
	static var ALL_SYMBOLS:Array = [DEMONIC, CYBERNETIC, PSYCHIC, RAMPART, EXPERIMENTAL];
	
	public var m_Inventory:MovieClip;
	public var GameClip:MovieClip;
	public var GameGrid:Array;
	public var index:Number = 0;
	public var Symbols:Array;
	public var MatchCount:Number;
	public var m_Columns:Number;
	public var m_Rows:Number;
	
	public function Aegis(root)
	{
		m_Inventory = root;
		m_Inventory.RedrawGrid();
		GameClip = m_Inventory.m_WindowMC.createEmptyMovieClip("Aegis", m_Inventory.m_WindowMC.getNextHighestDepth());
		GameClip._x = m_Inventory.m_WindowMC.i_Content._x;
		GameClip._y = m_Inventory.m_WindowMC.i_Content._y;
	}
	
	public function Start(inventory)
	{
		var board:Array = Common.GetRandom(BOARD_SHAPES);
		m_Columns = board[Enum_GridSize][0];
		//m_Inventory.m_WindowMC.i_FrameName.m_Text.text = board[7];
		m_Inventory.SetName(board[7]);
		m_Rows = board[Enum_GridSize][1];
		MakeGrid(m_Columns, m_Rows);
		if ( m_Inventory.m_Rows != m_Rows || m_Inventory.m_Columns != m_Columns)
		{
			m_Inventory.ResizeBoxTo(m_Rows, m_Columns, false, true);
		}
		Symbols = [];
		for (var i = 0; i < board[Enum_SymbolCount]; i++)
		{
			Symbols.push(ALL_SYMBOLS[i]);
		}
		for ( var i in board[Enum_Symmetric])
		{
			var loc = board[Enum_Symmetric][i];
			AddStaticShape(loc[0], loc[1], loc[2], loc[3]);
			AddStaticShape(m_Columns - loc[0] - 1, loc[1], loc[2], loc[3]);
			AddStaticShape(loc[0], m_Rows - 1 - loc[1], loc[2], loc[3]);
			AddStaticShape(m_Columns - loc[0] -1 , m_Rows - loc[1] - 1, loc[2], loc[3]);
		}
		for ( var i in board[Enum_MirroredHorizontal])
		{
			var loc = board[Enum_MirroredHorizontal][i];
			AddStaticShape(loc[0], loc[1], loc[2], loc[3]);
			AddStaticShape(loc[0], m_Rows - loc[1] - 1, loc[2], loc[3]);
		}
		for ( var i in board[Enum_MirroredVertical])
		{
			var loc = board[Enum_MirroredVertical][i];
			AddStaticShape(loc[0], loc[1], loc[2], loc[3]);
			AddStaticShape(m_Columns - loc[0] - 1, loc[1], loc[2], loc[3]);

		}
		for ( var i in board[Enum_Static])
		{
			var loc = board[Enum_Static][i];
			AddStaticShape(loc[0], loc[1], loc[2], loc[3]);
		}
		MatchCount = board[Enum_MatchCount];
		return GenerateBoard();
	}
	
	public function MakeGrid(rows, columns)
	{
		GameGrid = [];
		for (var x = 0; x < columns; x++)
		{
			GameGrid[x] = []
			for (var y = 0; y < rows; y++)
			{
				GameGrid[x][y] = false;
			}
		}
	}
	
	public function WipeBoard():Void 
	{
		for (var x = 0; x < GameGrid.length; x++)
		{
			for (var y = 0; y < GameGrid[x].length; y++)
			{
				if ( GameGrid[x][y] instanceof MovieClip)
				{
					MovieClip(GameGrid[x][y]).removeMovieClip();
					GameGrid[x][y] = false;
				}
			}
		}
	}
	
	public function WipeBoardColumn(x):Void 
	{
		for (var y = 0; y < GameGrid[x].length; y++)
		{
			if ( GameGrid[x][y] instanceof MovieClip)
			{
				MovieClip(GameGrid[x][y]).removeMovieClip();
				GameGrid[x][y] = false;
			}
		}
	}
	
	public function TryGenerateColumn(x)
	{
		var Attempts = 5;
		var failed:Boolean;
		
		while ( Attempts >= 0)
		{
			failed = false;
			for (var y = 0; y < GameGrid[x].length; y++)
			{
				if ( GameGrid[x][y] == false )
				{
					var symbolAttempts = Symbols.length;
					var symbolIndex = Common.GetRandomIndex(Symbols);
					while ( symbolAttempts >= 0 )
					{
						if ( WouldClear(Symbols[symbolIndex][3], x, y))
						{
							symbolIndex++;
							if ( !Symbols[symbolIndex]) symbolIndex = 0;
							symbolAttempts--;
						}
						else break;
					}
					if ( symbolAttempts == -1) 
					{
						failed = true;
						break;
					}
					var type = ALL_SYMBOLS[symbolIndex];
					var bounds:BlockBounds = Common.GetBlockBounds(m_Inventory, x, y);
					var BlockClip:MovieClip = GameClip.createEmptyMovieClip(index + "_" + x + y, GameClip.getNextHighestDepth());
					var itemBlock:ItemBlock = new ItemBlock(BlockClip);
					BlockClip.type = type[3];
					BlockClip.AegisBlock = true;
					BlockClip.x = x;
					BlockClip.y = y;
					BlockClip.bounds = bounds;
					GameGrid[x][y] = BlockClip;
					itemBlock.SetData(type[0], bounds, type[1], type[2], true, false);
					BlockClip._x = bounds.x;
					BlockClip._y = bounds.y;
					HookClip(BlockClip);
					index++;
				}
			}
			if ( failed )
			{
				WipeBoardColumn(x);
				Attempts--;
				if ( Attempts == -1) return false;
			}
			else return true;
		}
	}
	
	public function GenerateBoard()
	{
		var totalAttempts = 5;
		var failed:Boolean;
		
		while ( totalAttempts >= 0 )
		{
			failed = false;
			for (var x = 0; x < GameGrid.length; x++)
			{
				var result = TryGenerateColumn(x);
				if ( !result )
				{
					failed = true;
					WipeBoard();
					totalAttempts--;
					if ( totalAttempts == -1) return false;
					break;
				}
			}
			if (!failed)
			{
				return true;
			}
		}
		return;
	}
	
	public function HookClip(block:MovieClip)
	{
		block.onPress = Delegate.create(this, function(){this.StartDrag(block)});
		block.onRelease = block.onReleaseOutside = Delegate.create(this, function(){this.StopDrag(block)});
	}
	
	public var DragClip:MovieClip;
	public var DragTarget:MovieClip;
	public function StartDrag(block:MovieClip)
	{
		DragClip = block;
		DragTarget = undefined;
		Mouse.addListener(this);
	}
	
	public function onMouseMove(b, x, y)
	{
		var pos = m_Inventory.GetGridPositionAt(x, y);
		var clip = GameGrid[pos.x][pos.y];
		if (clip == DragClip){
			if ( DragTarget)
			{
				Tweener.addTween(DragClip, {_x:DragClip.bounds.x, _y:DragClip.bounds.y, time:0.3, transition:"linear"});
				Tweener.addTween(DragTarget, {_x:DragTarget.bounds.x, _y:DragTarget.bounds.y, time:0.3, transition:"linear"});
				DragTarget = undefined;
			}
			return;
		}
		
		if ((clip.x != DragClip.x && clip.y == DragClip.y) ||
			(clip.x == DragClip.x && clip.y != DragClip.y))
		{
			if 		( clip.x > DragClip.x) clip = GameGrid[DragClip.x + 1][DragClip.y];
			else if ( clip.x < DragClip.x) clip = GameGrid[DragClip.x - 1][DragClip.y];
			else if ( clip.y > DragClip.y) clip = GameGrid[DragClip.x][DragClip.y + 1];
			else if ( clip.y < DragClip.y) clip = GameGrid[DragClip.x][DragClip.y - 1];
			
			if (clip.AegisBlock)
			{
				if ( DragTarget == clip) return;
				if ( DragTarget )
				{
					Tweener.addTween(DragClip, {_x:DragClip.bounds.x, _y:DragClip.bounds.y, time:0.3, transition:"linear"});
					Tweener.addTween(DragTarget, {_x:DragTarget.bounds.x, _y:DragTarget.bounds.y, time:0.3, transition:"linear"});
				}
				DragTarget = clip;
				Tweener.addTween(DragTarget, {_x:DragClip.bounds.x, _y:DragClip.bounds.y, time:0.3, transition:"linear"});
				Tweener.addTween(DragClip, {_x:DragTarget.bounds.x, _y:DragTarget.bounds.y, time:0.3, transition:"linear"});
			}
		}
	}
	
	public function StopDrag(block:MovieClip)
	{
		Mouse.removeListener(this);
		if ( DragTarget )
		{
			var newX = DragTarget.x;
			var newY = DragTarget.y;
			
			var oldX = DragClip.x;
			var oldY = DragClip.y;
			
			var oldBounds:BlockBounds = Common.GetBlockBounds(m_Inventory, oldX, oldY);
			var newbounds:BlockBounds = Common.GetBlockBounds(m_Inventory, newX, newY);
			
			DragClip.x = newX;
			DragClip.y = newY;
			DragTarget.x = oldX;
			DragTarget.y = oldY;
			DragClip.bounds = newbounds;
			DragTarget.bounds = oldBounds;
			
			GameGrid[newX][newY] = DragClip;
			GameGrid[oldX][oldY] = DragTarget;
			
			var f = Delegate.create(this, function()
			{
				this.CheckPop(newX, newY);
				this.CheckPop(oldX, oldY);
			});
			
			Tweener.addTween(DragClip, {_x:newbounds.x, _y:newbounds.y, time:0.3, transition:"linear"});
			Tweener.addTween(DragTarget, {_x:oldBounds.x, _y:oldBounds.y, time:0.3, transition:"linear", onComplete:f});
		}
	}
	
	public function AnimatePop(clip:MovieClip):Void 
	{
		var f = function()
		{
			clip.removeMovieClip();
		}
		Tweener.addTween(clip, {_x:clip._x + clip._width/2, _y:clip._y + clip._height/2, _xscale:0, _yscale:0, time:0.3, transition:"easeinoutback", onComplete:f});
	}
	
	public function PopSymbols(targets:Array)
	{
		for (var i in targets)
		{
			var clip:MovieClip = GameGrid[targets[i].x][targets[i].y]
			GameGrid[targets[i].x][targets[i].y] = false;
			AnimatePop(clip);
		}
		setTimeout(Delegate.create(this, Respawn), 220);
	}
	
	public function MoveDown(x, y)
	{
		for (var y2 = y; y2 >= 0; y2--)
		{
			if ( GameGrid[x][y2] instanceof MovieClip)
			{
				var clip = GameGrid[x][y2];
				var found = false;
				for (var y3 = m_Rows; y3 >= 0; y3--)
				{
					if ( GameGrid[x][y3] == false)
					{
						var bounds:BlockBounds = Common.GetBlockBounds(m_Inventory, x, y3);
						found = true;
						GameGrid[x][y3] = clip;
						GameGrid[x][y3].x = x;
						GameGrid[x][y3].y = y3;
						GameGrid[x][y3].type = clip.type;
						GameGrid[x][y].bounds = bounds;
						GameGrid[x][y2] = false;
						Tweener.addTween(clip, {_x:bounds.x, _y:bounds.y, time:0.3, transition:"linear"});
						return true;
					}
				}
			}
		}
	}
	
	public function Respawn():Void 
	{
		var checkMoved:Array = [];
		for (var x = m_Columns; x >= 0; x--)
		{
			for (var y = m_Rows; y >= 0; y--)
			{
				if ( GameGrid[x][y] == false)
				{
					checkMoved.push([x, y]);
					var result = MoveDown(x, y);
					if (!result)
					{
						var symbol = Common.GetRandom(Symbols);
						var bounds:BlockBounds = Common.GetBlockBounds(m_Inventory, x, y);
						var BlockClip:MovieClip = GameClip.createEmptyMovieClip(index + "_" + x + y, GameClip.getNextHighestDepth());
						var itemBlock:ItemBlock = new ItemBlock(BlockClip);
						BlockClip.type = symbol[3];
						BlockClip.AegisBlock = true;
						BlockClip.x = x;
						BlockClip.y = y;
						BlockClip.bounds = bounds;
						GameGrid[x][y] = BlockClip;
						var animationBounds:BlockBounds = Common.GetBlockBounds(m_Inventory, 0, 0);
						itemBlock.SetData(symbol[0], bounds, symbol[1], symbol[2], true, false, animationBounds);
						BlockClip._x = bounds.x;
						BlockClip._y = bounds.y;
						HookClip(BlockClip);
						index++;
					}
				}
			}
		}
		setTimeout(Delegate.create(this, function()
		{
			for (var i in checkMoved)
			{
				
				this.CheckPop(checkMoved[i][0], checkMoved[i][1]);
			}
		}), 300);
	}
	
	public function CheckPop(x:Number, y:Number):Void 
	{
		var moved:MovieClip = GameGrid[x][y];
		var offset = MatchCount - 1;
		var confirmedPops:Array = [];
		var addedMoved:Boolean;
		
		var PopList:Array = [];
		for (var xOffset = -offset; xOffset <= offset; xOffset++){
			if ( xOffset == 0) continue;
			if ( GameGrid[x + xOffset][y].type == moved.type)
			{
				PopList.push(GameGrid[x + xOffset][y]);
			}
			else if ( PopList.length >= MatchCount - 1)
			{
				break;
			}
			else PopList = [];
		}
		if ( PopList.length >= MatchCount - 1)
		{
			confirmedPops.push(moved);
			for (var i in PopList)
			{
				confirmedPops.push(PopList[i]);
			}
			addedMoved = true;
		}
		
		PopList = [];
		for (var yOffset = -offset; yOffset <= offset; yOffset++){
			if ( yOffset == 0) continue;
			if ( GameGrid[x][y + yOffset].type == moved.type)
			{
				PopList.push(GameGrid[x][y + yOffset]);
			}
			else if ( PopList.length >= MatchCount - 1)
			{
				break;
			}
			else PopList = [];
		}
		if ( PopList.length >= MatchCount - 1)
		{
			if(!addedMoved) confirmedPops.push(moved);
			for (var i in PopList)
			{
				confirmedPops.push(PopList[i]);
			}
			addedMoved = true;
		}
		if ( confirmedPops.length > 0) 
		{
			PopSymbols(confirmedPops);
		}
	}
	
	
	//Supports
	public function WouldClear(type, x, y)
	{
		var matchCount = MatchCount;
		
		var offset = MatchCount - 1;
		var matches = 1; //always matches self
		for (var xOffset = -offset; xOffset <= offset; xOffset++){
			if ( xOffset == 0) continue;
			if ( GameGrid[x + xOffset][y].type == type)
			{
				matches++;
				if (matches == matchCount) return true;
			}
			else matches = 0;
		}
		
		matches = 1; //always matches self
		for (var yOffset = -offset; yOffset <= offset; yOffset++){
			if ( yOffset == 0) continue;
			if ( GameGrid[x][y + yOffset].type == type)
			{
				matches++;
				if (matches == matchCount) return true;
			}
			else matches = 0;
		}
		return false;
	}
	
	public function AddStaticShape(x, y, type, color)
	{
		GameGrid[x][y] = true;
		var bounds:BlockBounds = Common.GetBlockBounds(m_Inventory, x, y);
		var BlockClip = GameClip.createEmptyMovieClip(index + "_" + x + y, GameClip.getNextHighestDepth());
		BlockClip.AegisBlock = false;
		BlockClip.x = x;
		BlockClip.y = y;
		index++;
		if ( type == undefined)
		{
			var iconBlock:IconBlock = new IconBlock(BlockClip, bounds);
			iconBlock.SetData(5381610, 45, [3, 3], 0x350202, 20);
		}
		else
		{
			var iconBlock:DrawnShape = new DrawnShape(BlockClip, bounds);
			iconBlock.SetData(type, color);
		}
		BlockClip._x = bounds.x;
		BlockClip._y = bounds.y;
	}
}