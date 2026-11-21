import test from 'node:test'
import assert from 'node:assert/strict'
import { orderActions } from '../src/order-actions.mjs'

test('each role can advance its part of a delivery', () => {
  assert.deepEqual(orderActions('FARMER', 'REQUESTED'), ['ACCEPT', 'REJECT'])
  assert.deepEqual(orderActions('FARMER', 'ACCEPTED'), ['ASSIGN', 'CANCEL'])
  assert.deepEqual(orderActions('LOGISTICS', 'ASSIGNED'), ['PICK_UP'])
  assert.deepEqual(orderActions('LOGISTICS', 'PICKED_UP'), ['DELIVER'])
})

test('pickup closes the cancellation window and admin only observes orders', () => {
  assert.deepEqual(orderActions('BUYER', 'ASSIGNED'), ['CANCEL'])
  for (const role of ['FARMER', 'BUYER', 'ADMIN']) assert.deepEqual(orderActions(role, 'PICKED_UP'), [])
  for (const role of ['FARMER', 'BUYER', 'ADMIN', 'LOGISTICS']) assert.deepEqual(orderActions(role, 'DELIVERED'), [])
})
