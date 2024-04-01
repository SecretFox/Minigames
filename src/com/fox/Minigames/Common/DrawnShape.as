import com.Utils.Draw;
import com.fox.Minigames.Aegis.Aegis;
import com.fox.Minigames.BlockBounds;

class com.fox.Minigames.Common.DrawnShape
{	
	private var m_Content:MovieClip;
	
    private var m_Type:Number;
	private var m_Bounds:BlockBounds;
	private var m_Color:Number;
    
    public function DrawnShape( clip:MovieClip, bounds:BlockBounds)
    {
		m_Content = clip.createEmptyMovieClip("m_Content", clip.getNextHighestDepth()); 
		m_Bounds = bounds;
    }
    
    public function SetData(type, color)
    {
		m_Type = type
		m_Color = color || 0xFFFFFF;
		CreateIcon();
    }
	
    public function CreateIcon()
    {
		if ( m_Type == Aegis.SHAPE_OROCHI0)
		{
			Draw.DrawRectangle(m_Content, 0, 0, m_Bounds.width, m_Bounds.height, m_Color);
		}
		else if ( m_Type == Aegis.SHAPE_OROCHI1)
		{
			m_Content.lineStyle(1, m_Color);
			m_Content.moveTo(0, 0);
			m_Content.beginFill(m_Color, 100);
			m_Content.lineTo(m_Bounds.width, m_Bounds.height);
			m_Content.lineTo(0, m_Bounds.height);
			m_Content.lineTo(0, 0);
			m_Content.endFill();
		}
		else if ( m_Type == Aegis.SHAPE_OROCHI2)
		{
			m_Content.lineStyle(1, m_Color);
			m_Content.moveTo(0, 0);
			m_Content.beginFill(m_Color, 100);
			m_Content.lineTo(m_Bounds.width, 0);
			m_Content.lineTo(0, m_Bounds.height);
			m_Content.lineTo(0, 0);
			m_Content.endFill();
		}
		else if ( m_Type == Aegis.SHAPE_OROCHI3)
		{
			m_Content.lineStyle(1, m_Color);
			m_Content.moveTo(0, 0);
			m_Content.beginFill(m_Color, 100);
			m_Content.lineTo(m_Bounds.width, 0);
			m_Content.lineTo(0, m_Bounds.height);
			m_Content.lineTo(0, 0);
			m_Content.endFill();
		}
		else if ( m_Type == Aegis.SHAPE_OROCHI4)
		{
			m_Content.lineStyle(1, m_Color);
			m_Content.moveTo(0, m_Bounds.height);
			m_Content.beginFill(m_Color, 100);
			m_Content.lineTo(m_Bounds.width, 0);
			m_Content.lineTo(m_Bounds.width, m_Bounds.height);
			m_Content.lineTo(0, m_Bounds.height);
			m_Content.endFill();
		}
    }
}
