package com.proyecto.erpventas.application.usecases.categoria;

import com.proyecto.erpventas.application.dto.request.categoria.CreateCategoriaDTO;
import com.proyecto.erpventas.domain.model.inventory.CategoriaProducto;
import com.proyecto.erpventas.infrastructure.repository.categoria.CategoriaProductoRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CreateCategoriaUseCase {

    private final CategoriaProductoRepository categoriaRepository;

    public CreateCategoriaUseCase(CategoriaProductoRepository categoriaRepository) {
        this.categoriaRepository = categoriaRepository;
    }

    public CategoriaProducto create(CreateCategoriaDTO dto) {
        // 1) Si ya hay una activa, bloquear
        if (categoriaRepository.findActiveByNombre(dto.getNombre()).isPresent()) {
            throw new RuntimeException("Ya existe una categoría con ese nombre");
        }

        // 2) Si hay una inactiva, reactivar y actualizar
        Optional<CategoriaProducto> inactiva = categoriaRepository.findByNombre(dto.getNombre())
                                                                  .filter(c -> !c.getActivo());
        if (inactiva.isPresent()) {
            CategoriaProducto cat = inactiva.get();
            cat.setDescripcion(dto.getDescripcion());
            cat.setActivo(true);
            return categoriaRepository.save(cat);
        }

        // 3) No existe ninguna: crear nueva
        CategoriaProducto nueva = new CategoriaProducto();
        nueva.setNombre(dto.getNombre());
        nueva.setDescripcion(dto.getDescripcion());
        nueva.setActivo(true);
        return categoriaRepository.save(nueva);
    }
}
