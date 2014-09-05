<%-- 
	Renders Application Table and Standard Table

	Required Parameters:
		contentItem
			The content item 
		product
			The product repository item

	Optional Parameters:

--%>
<dsp:page>
	<dsp:tomap var="contentItemToMap" param="contentItem" />
	<dsp:getvalueof var="product" param="product" />

	<dsp:getvalueof var="showAllImageAtOnce" value="${param.bryanShowAllImageTest == 'true' ? true : false}" />

	<dsp:getvalueof var="simpPrd" value="" />
	<c:if test="${!showAllImageAtOnce}">
		<dsp:droplet name="/cst/droplet/ProductPropertiesLookupDroplet">
			<dsp:param name="product" value="${product}" />
			<dsp:param name="elementName" value="product" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="simpPrd" param="product" />

				<dsp:getvalueof var="hasImage" value="${false}" />
				<c:forEach var="application" items="${simpPrd.applications}" varStatus="applicationStatus">
					<c:if test="${fn:length(application.images)>0}">
						<dsp:getvalueof var="hasImage" value="${true}" />
					</c:if>
				</c:forEach>
				<c:if test="${!hasImage}">
					<dsp:getvalueof var="simpPrd" value="" />
				</c:if>
			</dsp:oparam>
		</dsp:droplet>
	</c:if>

	<div class="page-overview">
		<div class="line">

			<c:choose>
				<c:when test="${not empty simpPrd}">
					<div class="unit productHasApplication_${productHasApplication} showAllImageAtOnce_${showAllImageAtOnce}">
						<div class="brick-container shield" id="application-panel">
							<div class="container-inner ${applicationPanelCss}">

								<div class="line">
									<div class="unit">

										<h4 class="title">APPLICATIONS</h4>

									</div>
									<div class="unit">

										<div id="application-nav">
											<a href="javascript:void(0)" class="btn btn-link" data-role="prev">
												PREV. <img src="/img/demo/product-detail/arrow-prev.png" alt="Previous">
											</a>
											<a href="javascript:void(0)" class="btn btn-link" data-role="next">
												<img src="/img/demo/product-detail/arrow-next.png" alt="Next"> NEXT.
											</a>
										</div>

									</div>
								</div>


								<div class="line">
									<div class="unit size1of1">

										<ul id="application-table">
											<c:forEach var="application" items="${simpPrd.applications}" varStatus="applicationStatus">
											<cst:getDynamicProperty var="protocols" propertyName="protocols" dynamicBean="${application}" />
												<cst:getApplicationColor var="color" applicationCode="${application.code}" />
												<li class="application-type ${simpPrd.defaultAppCode == application.code ? ' active' : '' }" data-tabIndex="${applicationStatus.index}">
													<a data-theme="${color}" data-toggle="tab" data-application="${applicationStatus.index}" data-tabIndex="${applicationStatus.index}" data-group="${applicationStatus.index}" href="#application-type-${fn:toUpperCase(application.code)}" class="${empty application.images && empty application.protocols ? 'disabled' : ''}">
														<c:set var="imageAlt" value=""/>
														<cst:getApplicationNameFromApplicationCode var="imageAlt" applicationCode="${fn:toLowerCase(application.code)}" />
														<img src="/img/demo/common/application-${fn:toLowerCase(application.code)}.png" class="application-icon" alt="${application.method}">
													</a>
													<span class="application-indicator ${color}"></span>
												</li>
											</c:forEach>
										</ul>

									</div>
								</div>

							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="unit hide  productHasApplication_${productHasApplication} showAllImageAtOnce_${showAllImageAtOnce}">
						<ul id="application-table">
							<li class="application-type active" data-tabIndex="0}">
								<a data-theme="" data-toggle="tab" data-application="0" data-tabIndex="0" data-group="$0" href="#application-type-prdNoApp" class="">
									<img alt="" src="" class="application-icon">
								</a>
								<span class="application-indicator"></span>
							</li>
						</ul>
					</div>
				</c:otherwise>
			</c:choose>


			<div class="unit lastUnit">
				<table class="table" id="standard-table">
					<tr>
						<th>
							<cst:displayStandardTableAttributeLabel product="${product}" attributeName="${contentItemToMap.standardTableAttribute1}" />
						</th>
						<th>
							<cst:displayStandardTableAttributeLabel product="${product}" attributeName="${contentItemToMap.standardTableAttribute2}" />
						</th>
						<th>
							<cst:displayStandardTableAttributeLabel product="${product}" attributeName="${contentItemToMap.standardTableAttribute3}" />
						</th>
						<th>
							<cst:displayStandardTableAttributeLabel product="${product}" attributeName="${contentItemToMap.standardTableAttribute4}" />
						</th>
					</tr>
					<tr>
						<td>
							<cst:displayStandardTableAttributeValue product="${product}" attributeName="${contentItemToMap.standardTableAttribute1}" />
						</td>
						<td>
							<cst:displayStandardTableAttributeValue product="${product}" attributeName="${contentItemToMap.standardTableAttribute2}" />
						</td>
						<td>
							<cst:displayStandardTableAttributeValue product="${product}" attributeName="${contentItemToMap.standardTableAttribute3}" />
						</td>
						<td>
							<cst:displayStandardTableAttributeValue product="${product}" attributeName="${contentItemToMap.standardTableAttribute4}" />
						</td>
					</tr>
				</table>
			</div>

		</div>
		<!-- .line -->
	</div>
</dsp:page>