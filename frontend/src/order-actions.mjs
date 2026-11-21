export function orderActions(role, status) {
  if (role === 'FARMER') {
    if (status === 'REQUESTED') return ['ACCEPT', 'REJECT']
    if (status === 'ACCEPTED') return ['ASSIGN', 'CANCEL']
    if (status === 'ASSIGNED') return ['CANCEL']
  }
  if (role === 'BUYER' && ['REQUESTED', 'ACCEPTED', 'ASSIGNED'].includes(status)) return ['CANCEL']
  if (role === 'LOGISTICS' && status === 'ASSIGNED') return ['PICK_UP']
  if (role === 'LOGISTICS' && status === 'PICKED_UP') return ['DELIVER']
  return []
}
