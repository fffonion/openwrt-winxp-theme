param(
	[string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

function Assert-Contains {
	param(
		[string]$Path,
		[string]$Pattern,
		[string]$Message
	)

	$text = Get-Content -Raw -LiteralPath (Join-Path $Root $Path)
	if ($text -notmatch $Pattern) {
		throw $Message
	}
}

function Assert-File {
	param(
		[string]$Path,
		[string]$Message
	)

	if (-not (Test-Path -LiteralPath (Join-Path $Root $Path))) {
		throw $Message
	}
}

Assert-Contains 'htdocs/luci-static/xp/cascade.css' '--xp-title-blue' 'XP Luna title color token is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' 'win98-xp-desktop-sky' 'XP desktop sky/hill background layer is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' '--xp-wallpaper: url\("/luci-static/xp/wallpapers/wikipedia-bliss.svg"\)' 'Wikipedia Bliss wallpaper token is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' 'linear-gradient\(180deg, #1f5fd5 0%, #3b8df1 11%, #2469dc 42%, #174bb9 73%, #0c3d9c 100%\)' 'XP taskbar gradient is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' 'border-radius: 8px 8px 0 0' 'XP rounded window titlebar corners are missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' 'Windows XP Luna' 'XP reference comment is missing.'
Assert-Contains 'htdocs/luci-static/xp/mobile.css' '--xp-title-blue' 'Mobile XP token override is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' 'XP polish fixes verified against the live LuCI desktop' 'Live visual polish fixes are missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' '\.win98-start\[open\] \.win98-start-menu' 'Start menu column layout fix is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' '\.win98-window-button\[data-window-action="close"\]::before' 'XP titlebar button icon fix is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' '\.win98-window-button\[data-window-action="minimize"\],' 'XP titlebar button background reset is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' 'radial-gradient\(circle at 32% 24%' 'XP titlebar buttons should use glossy Luna-style button shading.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' '\.win98-window-button\[data-window-action="maximize"\]::before' 'XP maximize button glyph is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' '\.win98-window-button\[data-window-action="restore"\]::after' 'XP restore button double-window glyph is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' '\.win98-auth-titlebar-buttons \.is-help::before' 'XP login help button glyph is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' '\.cbi-progressbar > div' 'XP progressbar style fix is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' 'XP command button states matched against the Visual Guidelines reference' 'XP command button state override is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' 'border-color: #f2a11a !important' 'XP command button hover orange border is missing.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' 'color: #000000 !important' 'XP command buttons must keep black text in all states.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' '--xp-start-button-image: url\("/luci-static/xp/xp-start-button.png\?v=20260517-xp-taskbar2"\)' 'Real XP Start button image is missing from CSS.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' 'linear-gradient\(180deg, #fffef8 0%, #f6edd2 46%, #ecd08a 49%, #d6b15f 100%\)' 'XP action buttons should use Luna beige styling, not green.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' '\.cbi-button-save' 'LuCI save buttons must be covered by the XP beige button override.'
Assert-Contains 'ucode/template/themes/xp/footer.ut' '>start<' 'XP Start button text should be lowercase.'
Assert-Contains 'htdocs/luci-static/xp/cascade.css' '\.win98-start::after \{\s*display: none;' 'XP taskbar should not show the old Win98 Start divider.'
Assert-Contains 'htdocs/luci-static/xp/mobile.css' '\.win98-tray \{\s*margin-left: auto;' 'XP notification area should stay aligned to the right on mobile.'
Assert-Contains 'ucode/template/themes/xp/header.ut' 'cascade\.css\?v=20260517-xp-taskbar2' 'XP stylesheet cache buster is missing.'
Assert-Contains 'ucode/template/themes/xp/header.ut' 'xp-start-emblem\.png\?v=20260517-xp-taskbar2' 'XP favicon should use the source-derived emblem PNG.'

$mobile = Get-Content -Raw -LiteralPath (Join-Path $Root 'htdocs/luci-static/xp/mobile.css')
if ($mobile -match 'openwrt\.org/mobile\.css') {
	throw 'Mobile stylesheet still imports missing openwrt.org/mobile.css.'
}

Assert-File 'htdocs/luci-static/xp/xp-start-button.png' 'XP Start button image is missing.'
Assert-File 'htdocs/luci-static/xp/xp-start-emblem.png' 'XP Start emblem image is missing.'
Assert-File 'htdocs/luci-static/xp/xp-start-source.txt' 'XP Start button source file is missing.'
Assert-Contains 'htdocs/luci-static/xp/xp-start-source.txt' 'WindowsXPDesignGuidelines' 'XP Start button source does not reference the visual guidelines source.'
Assert-File 'htdocs/luci-static/xp/wallpapers/wikipedia-bliss.svg' 'Wikipedia Bliss wallpaper asset is missing.'
Assert-File 'htdocs/luci-static/xp/wallpapers/wikipedia-bliss-source.txt' 'Wikipedia Bliss wallpaper source file is missing.'
Assert-File 'htdocs/luci-static/xp/icons/menu/large/xp-icons-source.txt' 'XP icon source file is missing.'
Assert-Contains 'htdocs/luci-static/xp/icons/menu/large/xp-icons-source.txt' 'softwarehistorysociety/XPIcons' 'XP icon source does not reference the selected upstream icon library.'
Assert-Contains 'htdocs/luci-static/xp/icons/menu/large/xp-icons-source.txt' 'windows-icon-archive/#winxp' 'XP icon source does not reference Windows Icon Archive.'

Write-Host 'XP theme style checks passed.'
