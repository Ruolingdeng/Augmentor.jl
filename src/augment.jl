function augment{N}(img, pipeline::Pipeline{N})
    plain_array(_augment(img, pipeline))
end

function augment(img, pipeline::Pipeline{1})
    plain_array(applyeager(first(pipeline), img))
end

function augment(img, op::Operation)
    plain_array(applyeager(op, img))
end

# --------------------------------------------------------------------

@inline function _augment{N}(img, pipeline::Pipeline{N})
    _augment(img, pipeline...)
end

@generated function _augment(img, pipeline::Vararg)
    Expr(:block, Expr(:meta, :inline), build_pipeline(:img, pipeline))
end
