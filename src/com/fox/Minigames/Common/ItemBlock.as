import caurina.transitions.Tweener;
import com.GameInterface.InventoryBase;
import com.GameInterface.InventoryItem;
import com.Utils.Colors;
import com.Utils.Draw;
import com.fox.Minigames.BlockBounds;
import mx.utils.Delegate;

class com.fox.Minigames.Common.ItemBlock
{	
	private var m_Content:MovieClip;
	private var m_Icon:MovieClip;
    private var m_IconId:Number;
    
	public var m_IconLoader:MovieClipLoader;
	public var m_InventoryItem:InventoryItem;
	
	public var m_OverrideStroke:Number;
	public var m_OverrideBG:Number;
	public var m_ShowStroke:Boolean = true;
	public var m_ShowBG:Boolean = true;
	public var m_Bounds:BlockBounds;
	public var m_AnimationBounds:BlockBounds;
    
    public function ItemBlock( ItemSlotClip:MovieClip)
    {
		m_Content = ItemSlotClip.createEmptyMovieClip("m_Content", ItemSlotClip.getNextHighestDepth()); 
		m_Content._x = 4;
		m_Content._y = 4;
		var mclistener:Object = new Object();
		mclistener.onLoadComplete = Delegate.create(this, function(target:MovieClip)
		{
			target._xscale = 40;
			target._yscale = 40;
		});
		m_IconLoader = new MovieClipLoader();
		m_IconLoader.addListener( mclistener );
    }
    
    public function SetData(id, bounds, bg, stroke, showStroke, showBG, animationBounds)
    {
		m_InventoryItem = InventoryBase.CreateACGItemFromTemplate(id, 0, 0, 1);
		m_Bounds = bounds;
        m_IconId = m_InventoryItem.m_Icon.GetInstance();
		m_OverrideBG = bg;
		m_OverrideStroke = stroke;
		if ( showStroke != undefined ) m_ShowStroke = showStroke;
		if ( showBG != undefined ) m_ShowBG = showBG;
		m_AnimationBounds = animationBounds;
		CreateIcon();
    }
	
    private function GetRarityColor():Number
    {
        var color:Number = -1;
        switch(m_OverrideStroke || m_InventoryItem.m_Rarity)
        {
            case _global.Enums.ItemPowerLevel.e_Superior:
                color = Colors.e_ColorBorderItemSuperior;
				break;
            case _global.Enums.ItemPowerLevel.e_Enchanted:
                color = Colors.e_ColorBorderItemEnchanted;
				break;
            case _global.Enums.ItemPowerLevel.e_Rare:
                color = Colors.e_ColorBorderItemRare;
				break;
			case _global.Enums.ItemPowerLevel.e_Epic:
                color = Colors.e_ColorBorderItemEpic;
				break;
			case _global.Enums.ItemPowerLevel.e_Legendary:
                color = Colors.e_ColorBorderItemLegendary;
				break;
			case _global.Enums.ItemPowerLevel.e_Red:
                color = Colors.e_ColorBorderItemRed;
				break;
        }
        return color;
    }
	
    public function CreateIcon()
    {
		if ( m_AnimationBounds)
		{
			m_Content._y = m_AnimationBounds.y - m_AnimationBounds.height;
			m_Content._alpha = 0;
			Tweener.addTween(m_Content, {_y:4, _alpha:100, time:0.3, transition:"linear"});
		}
		if ( m_ShowBG)
		{
			var m_Background = m_Content.attachMovie("ItemBackground_Plain", "m_Background", m_Content.getNextHighestDepth());
			var colorObject:Object = Colors.GetColorlineColors( m_OverrideBG || m_InventoryItem.m_ColorLine );
			Colors.ApplyColor( m_Background.background, colorObject.background);
			Colors.ApplyColor( m_Background.highlight, colorObject.highlight);
		}
		else
		{
			var BG = m_Content.createEmptyMovieClip("BG", m_Content.getNextHighestDepth());
			if ( m_OverrideBG )
			{
				Draw.DrawRectangle(BG, -4, -4, m_Bounds.width, m_Bounds.width, m_OverrideBG, 20);
			}
			else
			{
				Draw.DrawRectangle(BG, -4, -4, m_Bounds.width, m_Bounds.width, 0x350202, 1);
			}
			
		}
		
		m_Icon = m_Content.createEmptyMovieClip("m_Icon", m_Content.getNextHighestDepth());
		var iconString:String = "rdb:1000624:" + m_IconId;
		m_IconLoader.loadClip( iconString, m_Icon );
		
		if ( m_ShowStroke )
		{
			var m_Stroke = m_Content.attachMovie("ItemStroke_Plain", "m_Stroke", m_Content.getNextHighestDepth());
			Colors.ApplyColor( m_Stroke, GetRarityColor());
		}
    }
}
