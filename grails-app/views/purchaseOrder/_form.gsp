<%@ page import="vue.PurchaseOrder" %>



<div class="fieldcontain ${hasErrors(bean: purchaseOrderInstance, field: 'orderId', 'error')} required">
	<label for="orderId">
		<g:message code="purchaseOrder.orderId.label" default="Order Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="orderId" required="" value="${purchaseOrderInstance?.orderId}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseOrderInstance, field: 'productName', 'error')} required">
	<label for="productName">
		<g:message code="purchaseOrder.productName.label" default="Product Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="productName" required="" value="${purchaseOrderInstance?.productName}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseOrderInstance, field: 'totalAmount', 'error')} required">
	<label for="totalAmount">
		<g:message code="purchaseOrder.totalAmount.label" default="Total Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="totalAmount" required="" value="${purchaseOrderInstance?.totalAmount}"/>

</div>

