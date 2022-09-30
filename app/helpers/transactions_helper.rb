module TransactionsHelper

    def find_project_from_order(order_id)
        order = Order.find(order_id)
        project = order.project 
    end

end