package br.com.techx.aula_sb.service;

import br.com.techx.aula_sb.dto.AlunoRequest;
import br.com.techx.aula_sb.dto.AlunoResponse;
import br.com.techx.aula_sb.model.Aluno;
import br.com.techx.aula_sb.repository.AlunoRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import  org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AlunoService {

    @Autowired
    private AlunoRepository alunoRepository;

    public List<Aluno> buscar() {
        return alunoRepository.findAll();
    }

    public void create(AlunoRequest alunoRequest) {
        Aluno entity = new Aluno();

        BeanUtils.copyProperties(alunoRequest, entity);

        alunoRepository.save(entity);
    }

    public AlunoResponse findById(Long id) {
        Aluno aluno = alunoRepository.findById(id).orElseThrow(() -> new RuntimeException("ID NOT FOUND"));
        return new AlunoResponse(aluno.getId(), aluno.getAluno(), aluno.getIdade(), aluno.getRa());
    }
}
