<?php

error_reporting(E_ALL|E_STRICT);

define('NO_DIMENSIONS', true);

require_once(dirname(__FILE__).'/XMLARequest.php');

$MDXQuery[] = 	'SELECT 
				{[Measures].[Cajero], [Measures].[Factura], [Measures].[Forma de Pago]} ON columns,
				{[Cliente].Children} ON rows FROM [Ventas]';
$MDXQuery[] = 	'SELECT
				{[Cliente].Children} ON columns,
				{[Measures].[Cajero], [Measures].[Factura], [Measures].[Forma de Pago]} ON rows
				 FROM [Ventas]';

$MDXQuery[] = 'SELECT NON EMPTY 
					{[Measures].[Factura], 
					 [Measures].[Forma de Pago],
					 [Measures].[Total General]} ON columns, 
				NON EMPTY 
					{[Cliente].Children} ON rows 
				FROM [Ventas] 
				WHERE 
					([Producto.Departamentos].[All Producto.Departamentoss].[TECNOLOGIA])';


$Request =  new XMLARequest();
$Request->dataSource = 'Provider=Mondrian;DataSource=DatasisCubo;';
$Request->xmlaProvider = 'http://localhost:8080/mondrian/xmla.jsp';
$Request->setQueryFormat('Tabular');
$Request->Catalog = 'DatasisVentas';
$Request->mdxQuery($MDXQuery[2]);

$xmla = $Request->getMondrianResponse();
$xmlaRows = XMLARequest::getXMLASetOfRows($xmla);

print_r($xmlaRows);

?>