/*
* ...
* @author SecretFox
*/
import com.GameInterface.DistributedValue;
import com.GameInterface.DistributedValueBase;
import com.fox.Minigames.Aegis.Aegis;
import com.fox.Minigames.Common.Common;
import com.fox.Minigames.Gridris.Gridris;
import mx.utils.Delegate;
 
class com.fox.Minigames.Minigames
{
	static var instance:Minigames;
	public var m_SwfRoot:MovieClip;
	public var m_InventoryVisibile:DistributedValue;
	static var CurrentGridris:Gridris;
	
	public static function main(swfRoot:MovieClip):Void
	{
		instance = new Minigames(swfRoot);
		swfRoot.onLoad = function(){Minigames.instance.Load()};
		swfRoot.onUnload = function(){Minigames.instance.Unload()};
	}

	public function Minigames(root) {
		m_SwfRoot = root;
		m_InventoryVisibile = DistributedValue.Create("inventory_visible");
	}
	
	public function Load()
	{
		m_InventoryVisibile.SignalChanged.Connect(StartMinigame, this);
		HookIconBox();
		WaitForInventory();
	}
	
	public function Unload()
	{
		m_InventoryVisibile.SignalChanged.Disconnect(StartMinigame, this);
	}
	
	public function WaitForInventory()
	{
		if (!_root.backpack2.m_IconBoxes[0])
		{
			setTimeout(Delegate.create(this, WaitForInventory), 500);
			return;
		}
		StartMinigame();
	}
	
	private function HookIconBox()
	{
		if ( _global.GUI.Inventory.IconBox.prototype.EndWritingName.base) return;
		
		if (!_global.GUI.Inventory.IconBox.prototype.EndWritingName ||
			!_global.GUI.Inventory.ItemIconBox.prototype.ResizeBoxTo)
		{
			setTimeout(Delegate.create(this, HookIconBox), 500);
			return;
		}
		var f = function()
		{
			arguments.callee.base.apply(this, arguments);
			if (this.m_Name.toLowerCase() == "gridris")
			{
				this.SetPinned(true);
				Minigames.instance.StartMinigame(this);
			}
			else if ( this.m_Name.toLowerCase() == "aegis")
			{
				Minigames.instance.StartMinigame(this);
			}
		}
		f.base = _global.GUI.Inventory.IconBox.prototype.EndWritingName;
		_global.GUI.Inventory.IconBox.prototype.EndWritingName = f;
		
		f = function()
		{
			arguments.callee.base.apply(this, arguments);
			if ( String(this.m_Name).toLowerCase() == "gridris")
			{
				if ( this.Gridris && !arguments[3]){
					DistributedValueBase.SetDValue("Minigames_Gridris_width", this.m_NumColumns);
					DistributedValueBase.SetDValue("Minigames_Gridris_height", this.m_NumRows);
					this.Gridris.EndGame(true);
					this.Gridris.StartGame(this.m_NumRows, this.m_NumColumns);
				}
			}
		}
		f.base = _global.GUI.Inventory.ItemIconBox.prototype.ResizeBoxTo;
		_global.GUI.Inventory.ItemIconBox.prototype.ResizeBoxTo = f;
		
		f = function()
		{
			if ( String(this.m_Name).toLowerCase() == "gridris" || String(this.m_Name).toLowerCase() == "aegis")
			{
				return;
			}
			arguments.callee.base.apply(this, arguments);
		}
		f.base = _global.GUI.Inventory.ItemIconBox.prototype.RemoveGrid;
		_global.GUI.Inventory.ItemIconBox.prototype.RemoveGrid = f;
	}
	
	private function StartMinigame(clip)
	{
		var inventory:Array = Common.GetInventoryBoxes("gridris")[0];
		if ( inventory && !inventory["Gridris"] )
		{
			var rows = DistributedValueBase.GetDValue("Minigames_Gridris_height");
			var columns = DistributedValueBase.GetDValue("Minigames_Gridris_width");
			CurrentGridris = new Gridris(inventory);
			inventory["Gridris"] = CurrentGridris;
			if (inventory["m_NumRows"] != rows || inventory["m_NumColumns"] != columns)
			{
				inventory.ResizeBoxTo(rows, columns, false, true);
			}
			inventory.RedrawGrid();
			CurrentGridris.StartGame(rows, columns);
		}
		else if ( !inventory && CurrentGridris)
		{
			CurrentGridris.EndGame(true);
			CurrentGridris = undefined;
		}
		
		var AegisInventories:Array = Common.GetInventoryBoxes("aegis");
		for (var i in AegisInventories)
		{
			inventory = AegisInventories[i];
			if ( inventory["Aegis"] ) continue;
			var aegis:Aegis = new Aegis(inventory); 
			inventory["Aegis"] = aegis;
			aegis.Start();
		}
	}
}