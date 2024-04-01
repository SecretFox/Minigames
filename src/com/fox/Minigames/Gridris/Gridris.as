import caurina.transitions.Tweener;
import com.GameInterface.Chat;
import com.Utils.Draw;
import com.fox.Minigames.BlockBounds;
import com.fox.Minigames.Common.Common;
import com.fox.Minigames.Controls;
import com.fox.Minigames.Minigames;
import com.fox.Minigames.Gridris.*;
import com.sitedaniel.utils.Delegate;
import flash.filters.DropShadowFilter;
/**
 * ...
 * @author SecretFox
 */
class com.fox.Minigames.Gridris.Gridris
{
	static var MAX_LINE_CLEARS = 20;
	static var MAX_LEVELS = 30;
	static var COMBO_FORMATS:Array = [
		(new TextFormat("_StandardFont", 8, 0xFFFFFF, true)),
		(new TextFormat("_StandardFont", 9, 0xFFFF00, true)),
		(new TextFormat("_StandardFont", 10, 0xFB9804, true)),
		(new TextFormat("_StandardFont", 11, 0xFF1515, true))
	];
	
	static var SCORE_FORMATS:Array = [
		(new TextFormat("_StandardFont", 14, 0xFFFFFF, true)),
		(new TextFormat("_StandardFont", 14, 0xFFFF00, true)),
		(new TextFormat("_StandardFont", 14, 0xFB9804, true)),
		(new TextFormat("_StandardFont", 14, 0xFF1515, true)),
		(new TextFormat("_StandardFont", 14, 0xFF1515, true))
	];
	static var GRIDRIS_SHAPES:Array = [
		signet, flappy, talisman, distillate, glyph, thirdage, cache	
	];
	public var ShapeBag:Array = [];
	
	public var NeedsClearing:Boolean;

	public var Score:MovieClip;
	public var Level:TextField;
	public var Points:TextField;
	
	public var m_Rows:Number;
	public var m_Columns:Number;
	public var lastTick:Number;
	public var CurrentScore = 0;
	public var CurrentLevel = 1;
	public var CurrentLineClears = 0;
	public var CurrentShape:BaseShape;
	
	public var Animating:Boolean;
	public var AnimationStart:Number;
	public var AnimationTargets:Array;
	public var AnimationInterval:Number;
	
	public var m_Inventory:MovieClip;
	public var m_GameClip:MovieClip;
	public var GameGrid:Array;
	public var BlockCounter:Array;
	
	static function randomizer( a, b) {
		return ( Math.random() > .5 ) ? 1 : -1;
	}
	
	public function Gridris(inventory) 
	{
		m_Inventory = inventory;
	}
	
	public function StartGame(rows, columns)
	{
		m_Rows = rows;
		m_Columns = columns;
		m_Inventory.m_WindowMC.Gridris.removeMovieClip();
		m_GameClip = m_Inventory.m_WindowMC.createEmptyMovieClip("Gridris", m_Inventory.m_WindowMC.getNextHighestDepth());
		m_GameClip._x = m_Inventory.m_WindowMC.i_Content._x;
		m_GameClip._y = m_Inventory.m_WindowMC.i_Content._y;
		lastTick = getTimer();
		Controls.Register();
		ShapeBag = [];
		MakeGrid();
		Animating = false;
		DrawScore();
		m_GameClip.onEnterFrame = Delegate.create(this, OnEnterFrame);
	}
	
	public function MakeGrid()
	{
		GameGrid = [];
		BlockCounter = [];
		for (var x = 0; x < m_Columns; x++)
		{
			GameGrid[x] = []
			for (var y = 0; y < m_Rows; y++)
			{
				GameGrid[x][y] = false;
			}
		}
		for (var y = 0; y < m_Rows; y++)
		{
			BlockCounter[y] = 0;
		}
	}
	
	public function GetRandomShape():BaseShape
	{
		if (ShapeBag.length == 0)
		{
			for (var i in GRIDRIS_SHAPES)
			{
				ShapeBag.push(GRIDRIS_SHAPES[i]);
			}
			ShapeBag.sort(randomizer);
		}
		var shapeClass = ShapeBag.pop();
		return new shapeClass(this);
	}
	
	public function DrawScore()
	{
		Score.removeMovieClip();
		Score = m_GameClip.createEmptyMovieClip("Score", m_GameClip.getNextHighestDepth());
		Score._x = m_GameClip._parent.i_Background._x;
		var bounds = m_GameClip._parent.i_ResizeButton.getBounds(m_GameClip);
		Score._y = bounds["yMax"];
		Draw.DrawRectangle(Score, 0, 0, m_GameClip._parent.i_Background._width, 40, 0x000000, 70, [10, 10, 10, 10]);
		
		Points = Score.createTextField("Points", Score.getNextHighestDepth(), Score._width-110, 7, 100, 20);
		Points.setNewTextFormat(SCORE_FORMATS[0]);
		Points.setTextFormat(SCORE_FORMATS[0]);
		Points.autoSize = "right";
		UpdateScore();
		
		Level = Score.createTextField("Level", Score.getNextHighestDepth(), 10, 7, 100, 20);
		Level.setNewTextFormat(SCORE_FORMATS[0]);
		Level.setTextFormat(SCORE_FORMATS[0]);
		Level.autoSize = "left";
		Level.text = "1/40";
		UpdateLevelText();
	}
	
	public function UpdateScore()
	{
		Points.text = Math.floor(CurrentScore) +" pts";
	}
	
	public function UpdateLevelText()
	{
		var format = SCORE_FORMATS[Math.floor(CurrentLevel / 10)];
		Level.setNewTextFormat(format);
		Level.setTextFormat(format);
		Level.text = CurrentLevel + "/" + MAX_LEVELS;;
	}
	
	public function MakeStatic()
	{
		for (var i in CurrentShape.Shape[CurrentShape.rotation])
		{
			var GridX = CurrentShape.GetX(i);
			var GridY = CurrentShape.GetY(i);
			GameGrid[GridX][GridY] = m_GameClip[CurrentShape.index +"_"+ i];
			BlockCounter[GridY] += 1;
			if (BlockCounter[GridY] == m_Columns){
				NeedsClearing = true;
			}
		}
		CurrentShape = undefined;
	}
	
	public function ClearRows()
	{
		AnimationTargets = [];
		var Combo = 0;
		for (var y = BlockCounter.length; y >= 0; y--)
		{
			if ( BlockCounter[y] == m_Columns )
			{
				Combo++
				Animating = true;
				AnimationTargets.push(y);
				CreateComboText(y, Combo);
				CurrentLineClears += 1;
				if ( CurrentLineClears == MAX_LINE_CLEARS)
				{
					CurrentLineClears = 0;
					CurrentLevel += 1;
					if ( CurrentLevel > MAX_LEVELS)
					{
						CurrentLevel = MAX_LEVELS;
					}
					UpdateLevelText();
				}
			}
		}
		clearInterval(AnimationInterval);
		if ( AnimationTargets.length > 0 )
		{
			AnimationStart = getTimer();
			AnimationInterval = setInterval(Delegate.create(this, AnimationCallback),10);
			AnimationCallback();
		}
	}
	
	public function CreateComboText(y,Combo)
	{
		var bounds:BlockBounds = Common.GetBlockBounds(m_Inventory, m_Columns / 2, y);
		var Textclip:TextField = m_GameClip.createTextField("Text" + Combo, m_GameClip.getNextHighestDepth(), bounds.x, bounds.y, 50, 50);
		Textclip._xscale = Textclip._yscale = 0;
		var amount = Math.floor((Combo * 50 + Combo * 50 * CurrentLevel * 0.1) / 5) * 5;
		Textclip.filters = [new DropShadowFilter(0, 0, 0x000000, 0.8, 1.5, 1.5, 255, 1, false, false, false)];
		var remove = Delegate.create(this, function(){
			Textclip.removeTextField();
			this.CurrentScore += amount;
			this.UpdateScore();
		});
		var f = Delegate.create(this, function(){
			Tweener.addTween(Textclip, {_xscale:0, _yscale:0, _y:Textclip._y+50,time:(this.m_Columns * 100 + 200)/2000, onComplete:remove});
		});
		var format = COMBO_FORMATS[Combo - 1] || COMBO_FORMATS[COMBO_FORMATS.length - 1];
		Textclip.setTextFormat(format);
		Textclip.setNewTextFormat(format);
		
		Textclip.text = "+" + amount;
		Tweener.addTween(Textclip, {_xscale:200, _yscale:200, time:(this.m_Columns * 100 + 200)/2000, onComplete:f});
	}
	
	public function AnimationCallback()
	{
		var endTime = AnimationStart + m_Columns * 100 + 200;
		var currentTime = getTimer();
		if ( currentTime > endTime)
		{
			clearInterval(AnimationInterval);
			for (var index in AnimationTargets)
			{
				var targetY = AnimationTargets[index];
				for (var x = 0; x < GameGrid.length; x++)
				{
					var clip:MovieClip = GameGrid[x][targetY];
					clip.removeMovieClip();
					GameGrid[x][targetY] = false;
					BlockCounter[targetY] -= 1;
					for (var z = targetY - 1; z >= 0; z--)
					{
						var block:MovieClip = GameGrid[x][z];
						if (!block) continue;
						var newY = z + 1;
						var bounds:BlockBounds = Common.GetBlockBounds(m_Inventory, x, newY);
						GameGrid[x][z] = false;
						BlockCounter[z] -= 1;
						
						GameGrid[x][newY] = block;
						BlockCounter[newY] += 1;
						Tweener.addTween(block, {_x:bounds.x, _y:bounds.y, time:0.3});
					}
				}
			}
			NeedsClearing = false;
			Animating = false;
			return;
		}
		
		var elapsed:Number = currentTime - AnimationStart;
		for (var index in AnimationTargets)
		{
			var targetY = AnimationTargets[index];
			for (var x = 0; x < GameGrid.length; x++)
			{
				var blockClip:MovieClip = GameGrid[x][targetY];
				
				var delay:Number;
				if ( targetY % 2 != 0) delay = x * 100;
				else delay = (m_Columns - x ) * 100
				
				var clipProgress = (elapsed - delay);
				if ( elapsed < delay) continue;
				if ( clipProgress > 200 ) blockClip._alpha = 0;
				else
				{
					if (!blockClip.startX)
					{
						blockClip.startX = blockClip._x;
						blockClip.endX = blockClip._x + blockClip._width / 2;
						blockClip.startY = blockClip._y;
						blockClip.endY = blockClip._y + blockClip._height / 2;
					}
					var percentage = clipProgress / 200;
					var tween = ( 1 - percentage) * blockClip.startX + percentage * blockClip.endX;
					blockClip._x = tween;
					tween = ( 1 - percentage) * blockClip.startY + percentage * blockClip.endY;
					blockClip._y = tween;
					blockClip._xscale = blockClip._yscale = 100 - percentage*100;
				}
			}
		}
	}
	
	public function OnEnterFrame()
	{
		var tickSpeed:Number = 10000 / (15 + CurrentLevel * 5);
		var currentTime:Number = getTimer();
		if ( currentTime - lastTick > tickSpeed)
		{
			GameLoop();
		}
	}
	
	public function isActive() 
	{
		return 	m_Inventory.m_IsPinned ||
				Minigames.instance.m_InventoryVisibile.GetValue();
	}

	public function GameLoop()
	{
		if (!isActive()){
			return;
		}
		
		lastTick = getTimer()
		if ( Animating) {
			return;
		}
		if ( NeedsClearing)
		{
			ClearRows();
			return;
		}
		
		var shape:BaseShape = CurrentShape;
		
		if ( shape ) 
		{
			TryMove(shape, 0, 1, true);
			return;
		}
		shape = GetRandomShape();
		CurrentShape = shape;
		var CenterPoint:Array = [Math.round(m_Columns / 2), 1];
		var result = shape.Spawn(CenterPoint);
		
		if ( !result)
		{
			var repeats = 0;
			var f;
			
			var show = Delegate.create(this,function()
			{
				repeats++;
				if (repeats < 8) 
				{
					for (var i in shape.Shape[shape.rotation])
					{
						Tweener.addTween(this.m_GameClip[shape.index + "_" + i], {_alpha:100, time:0.5, transition:"linear", onComplete:f});
					}
				}
			});
			var hide = Delegate.create(this,function()
			{
				if (repeats < 8)
				{
					for (var i in shape.Shape[shape.rotation])
					{
						Tweener.addTween(this.m_GameClip[shape.index + "_" + i], {_alpha:0, time:0.5, transition:"linear", onComplete:show});
					}
				}
			});
			f = hide;
			hide();
			
			Chat.SignalShowFIFOMessage.Emit("GAME OVER", 0);
			EndGame();
			return;
		}
	}
	
	public function EndGame(supress)
	{
		Controls.Unregister();
		m_GameClip.onEnterFrame = undefined;
		clearInterval(AnimationInterval);
		CurrentShape = undefined;
		CurrentScore = 0;
		CurrentLevel = 1;
		CurrentLineClears = 0;
		if (!supress)
		{
			Chat.SignalShowFIFOMessage.Emit("New game starting soon", 0);
			setTimeout(Delegate.create(this, StartGame), 5000, m_Rows, m_Columns);
		}
	}
	
	public function TryMove(s:BaseShape, x, y, stick)
	{
		if (!s) return;
		var canMove:Boolean = true;
		for (var i = 0; i < s.Shape[s.rotation].length;i++ )
		{
			var GridX = s.GetX(i) + x;
			var GridY = s.GetY(i) + y;
			if (GameGrid[GridX][GridY] != false)
			{
				canMove = false; 
				break;
			}
		}
		if (canMove)
		{
			s.CurrentPosition[0] += x;
			s.CurrentPosition[1] += y;
			s.DrawShape();
		}
		else if ( stick )
		{
			MakeStatic();
			GameLoop();
		}
		return canMove;
	}
}