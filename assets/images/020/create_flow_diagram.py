"""
Create a diagram showing flow conservation at a connection point.
Three components connected, with arrows showing Q_flow summing to zero.
"""

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

# Create figure with white background - wider to avoid overlap
fig, ax = plt.subplots(1, 1, figsize=(12, 8))
ax.set_xlim(-6, 6)
ax.set_ylim(-5, 5)
ax.set_aspect('equal')
ax.axis('off')

# Central connection point
center = (0, 0)
ax.plot(*center, 'ko', markersize=18, zorder=10)

# Component boxes and flow arrows - repositioned to avoid overlap
components = [
    {
        'pos': (-5.5, 1.5),  # Top-left
        'label': 'Component A\n(Heat Source)', 
        'arrow_start': (-3, 2.25), 
        'arrow_end': (-0.3, 0.2), 
        'flow_label': 'Q_flow_a', 
        'flow_pos': (-1.8, 1.6), 
        'color': '#E74C3C'
    },
    {
        'pos': (-5.5, -3.5),  # Bottom-left
        'label': 'Component B\n(Conductor)', 
        'arrow_start': (-3, -2.75), 
        'arrow_end': (-0.25, -0.2), 
        'flow_label': 'Q_flow_b', 
        'flow_pos': (-1.8, -1.8), 
        'color': '#3498DB'
    },
    {
        'pos': (2.5, -1),  # Right side
        'label': 'Component C\n(Heat Capacitor)', 
        'arrow_start': (0.35, 0), 
        'arrow_end': (2.5, -0.25), 
        'flow_label': 'Q_flow_c', 
        'flow_pos': (1.5, 0.6), 
        'color': '#27AE60'
    },
]

for comp in components:
    # Draw component box
    box = mpatches.FancyBboxPatch(
        comp['pos'], 2.8, 1.5,
        boxstyle="round,pad=0.05,rounding_size=0.2",
        facecolor='#F8F9FA',
        edgecolor='#2C3E50',
        linewidth=2,
        zorder=1
    )
    ax.add_patch(box)
    
    # Component label - higher zorder to be above box
    ax.text(comp['pos'][0] + 1.4, comp['pos'][1] + 0.75, comp['label'],
            ha='center', va='center', fontsize=11, fontweight='bold', color='#2C3E50',
            zorder=10)
    
    # Draw flow arrow
    ax.annotate('',
                xy=comp['arrow_end'],
                xytext=comp['arrow_start'],
                arrowprops=dict(arrowstyle='->', color=comp['color'], lw=3),
                zorder=6)
    
    # Flow label - higher zorder
    ax.text(comp['flow_pos'][0], comp['flow_pos'][1], comp['flow_label'],
            ha='center', va='center', fontsize=12, fontstyle='italic', color=comp['color'],
            fontweight='bold', zorder=10)

# Connection point label - higher zorder
ax.text(0.6, 0.6, 'Connection\nPoint', ha='left', va='bottom', fontsize=11, 
        color='#2C3E50', fontstyle='italic', zorder=10)

# Conservation equation box - at top
eq_box = mpatches.FancyBboxPatch(
    (-3, 3.2), 6, 1.3,
    boxstyle="round,pad=0.1,rounding_size=0.3",
    facecolor='#FFF9E6',
    edgecolor='#F39C12',
    linewidth=2,
    zorder=1
)
ax.add_patch(eq_box)

ax.text(0, 3.95, 'Modelica generates automatically:', 
        ha='center', va='center', fontsize=12, color='#2C3E50', zorder=10)
ax.text(0, 3.5, 'Q_flow_a + Q_flow_b + Q_flow_c = 0', 
        ha='center', va='center', fontsize=14, fontweight='bold', 
        fontfamily='monospace', color='#E67E22', zorder=10)

# Title at bottom
ax.text(0, -4.5, 'Flow variables sum to zero at connection points', 
        ha='center', va='center', fontsize=14, fontweight='bold', color='#2C3E50', zorder=10)

plt.tight_layout()
plt.savefig('/Users/z004wd4j/Library/CloudStorage/OneDrive-SiemensHealthineers/00_Documents/99_Perso/Private/Books/Modelica/assets/images/020/02_flow_conservation.svg', 
            format='svg', bbox_inches='tight', facecolor='white', edgecolor='none')
plt.close()

print("✅ Diagram saved to assets/images/020/02_flow_conservation.svg")
