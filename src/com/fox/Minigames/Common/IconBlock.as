import com.GameInterface.InventoryItem;
import com.Utils.Draw;
import com.fox.Minigames.BlockBounds;
import mx.utils.Delegate;

class com.fox.Minigames.Common.IconBlock
{	
	private var m_Content:MovieClip;
	private var m_Icon:MovieClip;
	
    private var m_IconId:Number;
	private var m_Bounds:BlockBounds;
	private var m_Scale:Number = 40;
	private var m_Color:Number;
	private var m_Offset:Array;
	private var m_Opacity:Number;
    
	public var m_IconLoader:MovieClipLoader;
	public var m_InventoryItem:InventoryItem;
    
    public function IconBlock( ItemSlotClip:MovieClip, bounds:BlockBounds)
    {
		m_Content = ItemSlotClip.createEmptyMovieClip("m_Content", ItemSlotClip.getNextHighestDepth()); 
		m_Bounds = bounds;
		var mclistener:Object = new Object();
		mclistener.onLoadComplete = Delegate.create(this, function(target:MovieClip)
		{
			target._xscale = this.m_Scale || 40;
			target._yscale = this.m_Scale || 40;
			target._parent._alpha = this.m_Opacity;
		});
		m_IconLoader = new MovieClipLoader();
		m_IconLoader.addListener( mclistener );
    }
    
    public function SetData(id, overrideScale, overrideOffset, color, opacity)
    {
        m_IconId = id;
		m_Scale = overrideScale;
		m_Offset = overrideOffset;
		m_Color = color;
		m_Opacity = opacity;
		CreateIcon();
    }
	
    public function CreateIcon()
    {
		if ( m_Color)
		{
			Draw.DrawRectangle(m_Content, 0, 0, m_Bounds.width, m_Bounds.height, m_Color, 80);
		}
		m_Icon = m_Content.createEmptyMovieClip("m_Icon", m_Content.getNextHighestDepth());
		m_Icon._x = m_Offset[0] || 4;
		m_Icon._y = m_Offset[1] || 4;
		var iconString:String = "rdb:1000624:" + m_IconId;
		m_IconLoader.loadClip( iconString, m_Icon );
		
		//var inv = Gridris.AegisInventory;
		//m_Content.onMousePress = Delegate.create(inv, inv.SlotBackgroundPressed);
		//m_Content.onMouseRelease = Delegate.create(inv, inv.SlotBackgroundReleased);
    }
}
