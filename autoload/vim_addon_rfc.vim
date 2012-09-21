if !exists('g:vim_addon_rfc') | let g:vim_addon_rfc = {} | endif | let s:c = g:vim_addon_rfc

fun! vim_addon_rfc#OpenRFC(number)
  let dir = library#Call(s:c.cache_dir)
  if !isdirectory(dir) | call mkdir(dir, 'p') | endif
  let file_on_disk=dir.'/RFC'.a:number.'.txt'

  if !filereadable(file_on_disk)
    " download it
    let url = substitute(s:c.rfc_url_template, '${NR}',a:number,'g')
    let cmd = s:c.download_cmd
    let cmd = substitute(cmd,'TARGET',file_on_disk,'g')
    let cmd = substitute(cmd,'URL',url,'g')
    call system(cmd)
    if v:shell_error != 0
      throw 'download command '.cmd.' failed with status: '.v:shell_error
    endif
  endif
  if !filereadable(file_on_disk)
    echoe "couldn't neither find nor download ".file_on_disk
    return
  endif
  " open for reading
  let buf_nr=bufnr('.')
  exec "e ".file_on_disk
  if expand('%:p') == file_on_disk
    set readonly
    set ft=rfc
  endif
endfun

fun! vim_addon_rfc#CompleteRFCFiles(A,L,P)
  let fl = split(glob(s:c.cache_dir.'/*'),"\n")
  let l2 = filter(map(fl,"matchstr(v:val,'\\d\\+')"),"v:val=~'^".a:A."'")
  return join(l2,"\n")
endf
