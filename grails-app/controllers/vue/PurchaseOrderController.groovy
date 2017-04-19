package vue



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PurchaseOrderController {


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PurchaseOrder.list(params), model:[purchaseOrderInstanceCount: PurchaseOrder.count()]
    }

    def show(PurchaseOrder purchaseOrderInstance) {
        respond purchaseOrderInstance
    }

}
