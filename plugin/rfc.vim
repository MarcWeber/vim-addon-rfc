" vam#DefineAndBind('s:c','g:vim_addon_rfc', {})
if !exists('g:vim_addon_rfc') | let g:vim_addon_rfc = {} | endif | let s:c = g:vim_addon_rfc
let s:c.rfc_url_template = get(s:c, 'rfc_url_template', 'http://www.ietf.org/rfc/rfc${NR}.txt')

let s:c.cache_dir = get(s:c,'cache_dir', $HOME.'/rfcs')
let s:c.download_cmd = get(s:c,'download_cmd', 'wget -O TARGET URL')

command! -nargs=1 -complete=custom,vim_addon_rfc#CompleteRFCFiles RFC call vim_addon_rfc#OpenRFC(<f-args>)
