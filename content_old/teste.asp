<form action="uploadproduto.php" method="post" enctype="multipart/form-data">
    		<input type="hidden" name="id" value="<%=request("id")%>">
        
            <input name="arquivos[]" type="file" multiple="multiple">
            <input type="submit" value="ok">
        
</form>
</div>

<div class="text-center mt-4">
    
</div>