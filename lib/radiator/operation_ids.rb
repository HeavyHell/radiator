module Radiator
  module OperationIds
    IDS = {
      vote: 0,
      comment: 1,
      transfer: 2,
      transfer_to_vesting: 3,
      withdraw_vesting: 4,
      limit_order_create: 5,
      limit_order_cancel: 6,
      feed_publish: 7,
      convert: 8,
      account_create: 9,
      account_update: 10,
      witness_update: 11,
      account_witness_vote: 12,
      account_witness_proxy: 13,
      pow: 14,
      custom: 15,
      report_over_production: 16,
      delete_comment: 17,
      custom_json: 18,
      comment_options: 19,
      set_withdraw_vesting_route: 20,
      limit_order_create2: 21,
      challenge_authority: 22,
      prove_authority: 23,
      request_account_recovery: 24,
      recover_account: 25,
      change_recovery_account: 26,
      escrow_transfer: 27,
      escrow_dispute: 28,
      escrow_release: 29,
      pow2: 30,
      escrow_approve: 31,
      transfer_to_savings: 32,
      transfer_from_savings: 33,
      cancel_transfer_from_savings: 34,
      custom_binary_operation: 35,
      decline_voting_rights_operation: 36,
      reset_account_operation: 37,
      set_reset_account_operation: 38
    }
    
    def id(key)
      IDS[key]
    end
  end
end